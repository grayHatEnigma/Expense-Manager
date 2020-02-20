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

  // Cached - in memory - list of transactions.
  List<Transaction> _transactions;

  // Sort and return the cached list of transactions.
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

  // Group - required - transactions by category.
  // required by the PieChart Widget
  Map<Category, double> totalSpendingPerCategory(
      List<Transaction> requiredTransactionsList) {
    var newGroup = groupBy(
        requiredTransactionsList, (Transaction tx) => tx.category.title);

    final piChartMap = newGroup.map((categoryTitle, list) {
      return MapEntry(Category(categoryTitle), calculateTotalSpending(list));
    });
    return piChartMap;
  }

  // Calculate total spending amount for a transaction list.
  double calculateTotalSpending(List<Transaction> list) {
    double sum = 0;
    list.forEach((tx) => sum += tx.amount);
    return sum;
  }

  // Get transactions list for a certain time period.
  List<Transaction> recentTransactions({int differenceInDays}) {
    return _transactions.where((tx) {
      return (DateTime.now().difference(tx.date).inDays <= differenceInDays);
    }).toList();
  }

  // Get the last week transactions list
  List<Transaction> get lastWeekTransactions {
    return recentTransactions(differenceInDays: 7);
  }

  // Get spending that are grouped by day of the week
  List<ChartBar> get lastWeekSpendingByDay {
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
      return ChartBar(weekDay: currentDay, amount: totalSum);
    });
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
