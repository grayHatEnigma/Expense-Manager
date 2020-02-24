import 'dart:collection';
import "package:collection/collection.dart";
import 'package:flutter/widgets.dart';

//my imports
import '../models/transaction.dart';
import '../models/chart_bar.dart';
import '../models/category.dart';
import './database_manager.dart';

/// This class serves as a 'middle-man' between domain and ui.
class UiManager with ChangeNotifier {
  // Singleton instance from Ui Manager class.
  static final instance = UiManager._();
  factory UiManager() => instance;
  UiManager._() {
    // Initialize cached transactions list
    _transactions = dbManager.transactions;
  }

  // Database Manager instance
  final dbManager = DatabaseManager();

  // Analyze Date
  DateTime _analysisDate = DateTime.now();
  DateTime get analysisDate => _analysisDate;
  set analysisDate(newDate) {
    _analysisDate = newDate;
    notifyListeners();
  }

  // Cached - in memory - list of transactions.
  List<Transaction> _transactions;

  // Sort and return the cached list of all (income and expenses) transactions.
  UnmodifiableListView<Transaction> get transactionsList {
    _transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return UnmodifiableListView(_transactions.reversed.toList());
  }

  // Group - all - transactions by date.
  // required by the Transaction List/Card Widgets
  List<List<Transaction>> get groupedTransactionsByDate {
    var newGroup = groupBy(transactionsList, (Transaction tx) => tx.dayDate);
    return newGroup.values.toList();
  }

  // Expenses Transactions
  List<Transaction> get expensesList {
    return transactionsList.where((tx) {
      return tx.amount < 0;
    }).toList();
  }

  // Income Transactions
  List<Transaction> getExpensesOnly(List<Transaction> list) {
    return list.where((tx) {
      return tx.amount < 0;
    }).toList();
  }

  // Income Transactions
  List<Transaction> get incomeList {
    return transactionsList.where((tx) {
      return tx.amount > 0;
    }).toList();
  }

  // Calculate absolute total amount for a transaction list.
  double calculateTotalAmount(List<Transaction> list) {
    double sum = 0;
    list.forEach((tx) {
      sum += tx.amount;
    });
    return sum.abs();
  }

  // Get a transactions list for analysis - only takes the Expenses
  List<Transaction> analysisTransactions() {
    return expensesList.where((tx) {
      return (tx.date.month == analysisDate.month &&
          tx.date.year == analysisDate.year);
    }).toList();
  }

  // Get a transactions list for income - only takes the Income
  List<Transaction> incomeTransactions() {
    return incomeList.where((tx) {
      return (tx.date.month == analysisDate.month &&
          tx.date.year == analysisDate.year);
    }).toList();
  }

  // Get the last week transactions list
  List<Transaction> get lastWeekTransactions {
    return expensesList.where((tx) {
      return (DateTime.now().difference(tx.date).inDays < 7);
    }).toList();
  }

  // Get spending that are grouped by day of the week
  List<ChartBar> get lastWeekSpendingPerDay {
    return List.generate(7, (index) {
      final currentDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      lastWeekTransactions.forEach((tx) {
        if (tx.date.day == currentDay.day &&
            tx.date.month == currentDay.month &&
            tx.date.year == currentDay.year) {
          totalSum += tx.amount;
        }
      });
      return ChartBar(weekDay: currentDay, amount: totalSum.abs());
    });
  }

  ///////////////////// Pie Chart Widget /////////////////////

  // Group - required - expenses by category.
  // required by the PieChart Widget ( To Generate Pie Chart Sections )
  Map<Category, double> totalSpendingPerCategory() {
    var newGroup =
        groupBy(analysisTransactions(), (Transaction tx) => tx.category.title);

    final piChartMap = newGroup.map((categoryTitle, list) {
      return MapEntry(Category(categoryTitle), calculateTotalAmount(list));
    });
    return piChartMap;
  }

  // Group plan transactions by category required by details analysis

  Map<Category, List<Transaction>> analysisTransactionsPerCategory() {
    final Map<String, List<Transaction>> group =
        groupBy(analysisTransactions(), (Transaction tx) => tx.category.title);
    final Map<Category, List<Transaction>> requiredGroup =
        group.map((categoryTitle, list) {
      return MapEntry(Category(categoryTitle), list);
    });
    return requiredGroup;
  }

  /*
  Add , Delete , Update => Transaction.
   */

  // Add a new transaction.
  void addTransaction(
      {String title, double amount, DateTime date, Category category}) async {
    final transaction = Transaction(
        title: title, amount: amount, date: date, category: category);
    _transactions.add(transaction);

    // notify all widgets depends on this object
    notifyListeners();

    // add transaction to the database
    dbManager.addTransactionToDatabase(transaction);
  }

  // Delete an existing transaction.
  void deleteTransaction({int id}) async {
    _transactions.removeWhere((tx) => tx.id == id);

    // notify all widgets depends on this object
    notifyListeners();

    // delete transaction from the database
    dbManager.deleteTransactionFromDatabase(id);
  }

  // Reset / Delete all existing transactions in the database.
  void reset() async {
    _transactions = [];

    // notify all widgets depends on this object
    notifyListeners();

    // delete transactions from the database
    dbManager.deleteAllTransactionFromDatabase();
  }
}
