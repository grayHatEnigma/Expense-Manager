//flutter core
import 'dart:collection';
import 'package:expense_manager/domain/models/category.dart';
import 'package:flutter/widgets.dart';

//external packages
import 'package:date_format/date_format.dart';

//my imports
import './models/transaction.dart';
import './models/chart_bar.dart';
import 'package:expense_manager/domain/manager_database_contract.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';

/// The heart of the app
class Manager
    with ChangeNotifier
    implements ManagerUiContract, ManagerDatabaseContract {
  // a function to get the last week transactions
  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return (DateTime.now().difference(tx.date).inDays < 7);
    }).toList();
  }

  // Unmodified Version Of our transactions list
  UnmodifiableListView<Transaction> get transactionsList =>
      UnmodifiableListView(_transactions);

  /// UI Contract Functions
  // a function to get the total spending amount during the last week
  @override
  double get totalRecentSpending {
    double total = 0;
    _recentTransactions.forEach((tx) {
      total += tx.amount;
    });
    return total;
  }

  // a function to get transactions that are grouped by day of the week
  @override
  List<ChartBar> get groupedTransactions {
    return List.generate(7, (index) {
      final currentDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      _recentTransactions.forEach((tx) {
        if (tx.date.day == currentDay.day &&
            tx.date.month == currentDay.month &&
            tx.date.year == currentDay.year) {
          totalSum += tx.amount;
        }
      });
      return ChartBar(weekDay: formatDate(currentDay, [D]), amount: totalSum);
    });
  }

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
        date: DateTime(2020, 2, 2),
        category: Category.Others),
    Transaction(
        id: 't6',
        title: 'أدوات مكتبية',
        amount: 250,
        date: DateTime(2020, 2, 2),
        category: Category.Others),
  ];
} // TransactionsData class end
