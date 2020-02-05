import 'dart:collection';
import "package:collection/collection.dart";
import 'package:flutter/widgets.dart';

//external packages
import 'package:date_format/date_format.dart';

//my imports
import './models/transaction.dart';
import './models/chart_bar.dart';
import './models/category.dart';
import './manager_database_contract.dart';
import './manager_ui_contract.dart';

class Manager
    with ChangeNotifier
    implements ManagerUiContract, ManagerDatabaseContract {
  // List of Transactions
  List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'رواية الظل خارج الزمان',
        amount: 35,
        category: Category.Entertaining,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'بطاطس',
        amount: 25,
        date: DateTime.now(),
        category: Category.Grocery),
    Transaction(
        id: 't3',
        title: 'تذكرة قطر',
        amount: 40,
        date: DateTime.now(),
        category: Category.Transportation),
    Transaction(
        id: 't3',
        title: 'كوتشي جديد',
        amount: 535,
        date: DateTime(2020, 1, 30),
        category: Category.Shopping),
    Transaction(
        id: 't4',
        title: 'بنطلون جديد',
        amount: 250,
        date: DateTime(2020, 1, 29),
        category: Category.Shopping),
    Transaction(
        id: 't7',
        title: 'فاتورة التليفون الأرضي',
        amount: 79,
        date: DateTime(2020, 2, 3),
        category: Category.Bills),
    Transaction(
        id: 't5',
        title: 'زيارات عائلية',
        amount: 150,
        date: DateTime(2020, 2, 1),
        category: Category.Others),
    Transaction(
        id: 't6',
        title: 'أدوات مكتبية',
        amount: 250,
        date: DateTime(2020, 2, 1),
        category: Category.Others),
  ];

  /// Sorting and Grouping Functions

  // sort transaction list
  UnmodifiableListView<Transaction> get transactionsList {
    _transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return UnmodifiableListView(_transactions.reversed.toList());
  }

  // a function that group - all - transactions by date
  @override
  List<List<Transaction>> get groupedTransactionsByDate {
    var newGroup = groupBy(transactionsList, (Transaction tx) => tx.dayDate);
    return newGroup.values.toList();
  }

  // a function to get the last week transactions list
  List<Transaction> get _lastWeekTransactions {
    return _transactions.where((tx) {
      return (DateTime.now().difference(tx.date).inDays < 7);
    }).toList();
  }

  // a function to get the total spending amount during the last week
  @override
  double get lastWeekTotalSpending {
    double total = 0;
    _lastWeekTransactions.forEach((tx) {
      total += tx.amount;
    });
    return total;
  }

  // a function to get spending that are grouped by day of the week
  @override
  List<ChartBar> get lastWeekSpendingByDay {
    return List.generate(7, (index) {
      final currentDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      _lastWeekTransactions.forEach((tx) {
        if (tx.date.day == currentDay.day &&
            tx.date.month == currentDay.month &&
            tx.date.year == currentDay.year) {
          totalSum += tx.amount;
        }
      });
      return ChartBar(weekDay: formatDate(currentDay, [D]), amount: totalSum);
    });
  }

  /// Add , Delete Functions
  // Add a new transaction to the list
  @override
  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      String id,
      Category category}) {
    // add a new transaction
    _transactions.add(
      Transaction(
          title: title, amount: amount, date: date, id: id, category: category),
    );
    notifyListeners();
  }

  // Delete an existing transaction from the list
  @override
  void deleteTransaction({int index, String id}) {
    if (id == null) {
      _transactions.removeAt(index);
    } else {
      _transactions.removeWhere((tx) => tx.id == id);
    }

    notifyListeners();
  }

  /// Database Contract Functions
  @override
  List<Transaction> loadTXList() {
    // TODO: implement loadTXList
    return null;
  }

  @override
  void saveTXList() {
    // TODO: implement saveTXList
  }
} // TransactionsData class end
