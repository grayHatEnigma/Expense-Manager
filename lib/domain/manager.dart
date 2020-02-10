import 'dart:collection';
import "package:collection/collection.dart";
import 'package:flutter/widgets.dart';

//external packages
import 'package:date_format/date_format.dart';

//my imports
import './models/transaction.dart';
import './models/chart_bar.dart';
import './models/category.dart';
import './models/plan.dart';
import './manager_database_contract.dart';
import './manager_ui_contract.dart';

class Manager
    with ChangeNotifier
    implements ManagerUiContract, ManagerDatabaseContract {
  // Plan object for current user
  Plan _plan;

  bool get hasPlan => _plan != null;

  Manager() {
    //TODO: code to get _plan object -for the current user- if existed
  }

  /// Plan
  @override
  void setPlan({@required DateTime startDate, @required double totalIncome}) {
    if (_plan == null) {
      _plan = Plan(startDate: startDate, totalIncome: totalIncome);
    }

    // else 'edit' an existing plan object
  }

  @override
  Plan getPlan() {
    return hasPlan ? _plan : throw 'Plan Not Found';
  }

  /// Sorting and Grouping Functions

  // unmodifiable  sorted transaction list
  UnmodifiableListView<Transaction> get transactionsList {
    _plan.transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return UnmodifiableListView(_plan.transactions.reversed.toList());
  }

  // a function that group - required - transactions by category
  @override
  Map<Category, double> totalSpendingPerCategory(
      List<Transaction> requiredTransactionsList) {
    var newGroup = groupBy(
        requiredTransactionsList, (Transaction tx) => tx.category.category);

    final piChartMap = newGroup.map((categoryType, list) {
      return MapEntry(
          Category(category: categoryType), calculateTotalSpending(list));
    });
    return piChartMap;
  }

  // a function that group - all - transactions by date
  @override
  List<List<Transaction>> get groupedTransactionsByDate {
    var newGroup = groupBy(transactionsList, (Transaction tx) => tx.dayDate);
    return newGroup.values.toList();
  }

  // a function to get the total spending amount for a transaction list
  double calculateTotalSpending(List<Transaction> list) {
    double sum = 0;
    list.forEach((tx) => sum += tx.amount);
    return sum;
  }

  // a function to get  transactions list for a certain time
  List<Transaction> recentTransactions({int differenceInDays}) {
    return _plan.transactions.where((tx) {
      return (DateTime.now().difference(tx.date).inDays < differenceInDays);
    }).toList();
  }

  // a function to get the last week transactions list
  List<Transaction> get lastWeekTransactions {
    return recentTransactions(differenceInDays: 7);
  }

  // a function to get spending that are grouped by day of the week
  @override
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
    _plan.transactions.add(
      Transaction(
          title: title, amount: amount, date: date, id: id, category: category),
    );
    notifyListeners();
  }

  // Delete an existing transaction from the list
  @override
  void deleteTransaction({int index, String id}) {
    if (id == null) {
      _plan.transactions.removeAt(index);
    } else {
      _plan.transactions.removeWhere((tx) => tx.id == id);
    }
//
//    print('${_plan.totalIncome} , on ${_plan.startDate}');
//    print(groupedTransactionsByCategory(
//        recentTransactions(differenceInDays: 20)));
    notifyListeners();
  }

  /// Database Contract Functions
  @override
  List<Transaction> loadTXList() {
    // TODO: implement  getting Plan Object list from the database
    return null;
  }

  @override
  void saveTXList() {
    // TODO: implement saving Plan Object  list to the database
  }
} // Manager class end
