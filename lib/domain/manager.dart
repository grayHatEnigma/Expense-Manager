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
  //Plan(id: 'testId', startDate: DateTime(2020, 1, 30), totalIncome: 5000);
  bool get hasPlan => _plan != null;

  Manager() {
    //TODO: code to get _plan object for the current user if existed
  }
  // List of Transactions
  List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'رواية الظل خارج الزمان',
        amount: 35,
        category: Category(type: Type.Entertaining),
        date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'بطاطس',
      amount: 25,
      date: DateTime.now(),
      category: Category(type: Type.Grocery),
    ),
    Transaction(
      id: 't3',
      title: 'تذكرة قطر',
      amount: 40,
      date: DateTime.now(),
      category: Category(type: Type.Transportation),
    ),
    Transaction(
        id: 't4',
        title: 'كوتشي جديد',
        amount: 535,
        date: DateTime(2020, 2, 7),
        category: Category(type: Type.Shopping)),
    Transaction(
      id: 't5',
      title: 'فاتورة نت',
      amount: 250,
      date: DateTime(2020, 2, 6),
      category: Category(type: Type.Bills),
    ),
    Transaction(
      id: 't6',
      title: 'فاتورة التليفون الأرضي',
      amount: 79,
      date: DateTime(2020, 2, 3),
      category: Category(type: Type.Bills),
    ),
    Transaction(
      id: 't7',
      title: 'زيارات عائلية',
      amount: 150,
      date: DateTime(2020, 2, 2),
      category: Category(type: Type.Others),
    ),
    Transaction(
      id: 't8',
      title: 'رحلة أسوان',
      amount: 250,
      date: DateTime(2020, 2, 2),
      category: Category(type: Type.Travelling),
    ),
  ];

  /// Plan
  @override
  void setPlan({@required DateTime startDate, @required double totalIncome}) {
    if (_plan == null) {
      String id =
          startDate.hashCode.toString() + totalIncome.hashCode.toString();
      _plan = Plan(startDate: startDate, totalIncome: totalIncome, id: id);
    }

    // else 'edit' an existing plan object
  }

  @override
  Plan getPlan() {
    return hasPlan ? _plan : throw 'Plan Not Found';
  }

  /// Sorting and Grouping Functions

  // sort transaction list
  UnmodifiableListView<Transaction> get transactionsList {
    _transactions.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return UnmodifiableListView(_transactions.reversed.toList());
  }

  // a function that group - required - transactions by category
  @override
  Map<Category, double> totalSpendingPerCategory(
      List<Transaction> requiredTransactionsList) {
    var newGroup =
        groupBy(requiredTransactionsList, (Transaction tx) => tx.category.type);

    final piChartMap = newGroup.map((categoryType, list) {
      return MapEntry(
          Category(type: categoryType), calculateTotalSpending(list));
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
    return _transactions.where((tx) {
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
//
//    print('${_plan.totalIncome} , on ${_plan.startDate}');
//    print(groupedTransactionsByCategory(
//        recentTransactions(differenceInDays: 20)));
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
} // Manager class end
