import 'dart:collection';
import "package:collection/collection.dart";
import 'package:flutter/widgets.dart';

//external packages
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

//my imports
import './models/transaction.dart';
import './models/chart_bar.dart';
import './models/category.dart';
import './models/plan.dart';
import './manager_ui_contract.dart';
import '../infrastructure/database/database_helper.dart';

class Manager with ChangeNotifier implements ManagerUiContract {
  // Plan object for current user
  Plan _plan;

  bool get hasPlan => _plan != null;

  Manager() {
    readFromSharedPreferences();
  }

  /// Shared Preferences
  // a method to save the plan values in shared preferences
  void saveToSharedPreferences(DateTime date, double income) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('startDate', date.toString());
    sharedPreferences.setDouble('totalIncome', income);
  }

  // a method to read plan values from shared preferences if existed
  void readFromSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final dateString = sharedPreferences.getString('startDate');
    final income = sharedPreferences.getDouble('totalIncome');

    if (dateString != null && income != null) {
      print('plan date : $dateString  , plan income : $income');
      DateTime startDate = DateTime.parse(dateString);
      double totalIncome = income;
      createPlan(startDate: startDate, totalIncome: totalIncome);
    }
  }

  /// Plan
  @override
  void createPlan(
      {@required DateTime startDate, @required double totalIncome}) {
    if (_plan == null) {
      _plan = Plan(startDate: startDate, totalIncome: totalIncome);

      // shared pref part
      saveToSharedPreferences(startDate, totalIncome);
    }
  }

  @override
  Plan get plan {
    return hasPlan ? _plan : throw 'Plan Not Found';
  }

  /// Sorting and Grouping Functions

  // unmodifiable  sorted transaction list
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
    var newGroup = groupBy(
        requiredTransactionsList, (Transaction tx) => tx.category.title);

    final piChartMap = newGroup.map((categoryTitle, list) {
      return MapEntry(Category(categoryTitle), calculateTotalSpending(list));
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
      {String title, double amount, DateTime date, Category category}) {
    // add a new transaction
    _transactions.add(
      Transaction(title: title, amount: amount, date: date, category: category),
    );
    notifyListeners();
  }

  // Delete an existing transaction from the list
  @override
  void deleteTransaction({int index, int id}) {
    if (id == null) {
      _transactions.removeAt(index);
    } else {
      _transactions.removeWhere((tx) => tx.id == id);
    }

    notifyListeners();
  }

  /// Database Part

  // transactions list

  List<Transaction> _transactions = [
    Transaction(
        id: 1,
        title: 'رواية الظل خارج الزمان',
        amount: 35,
        category: Category('Entertaining'),
        date: DateTime.now()),
    Transaction(
      id: 2,
      title: 'بطاطس',
      amount: 25,
      date: DateTime.now(),
      category: Category('Grocery'),
    ),
    Transaction(
      id: 3,
      title: 'تذكرة قطر',
      amount: 40,
      date: DateTime.now(),
      category: Category('Transportation'),
    ),
    Transaction(
        id: 4,
        title: 'كوتشي جديد',
        amount: 535,
        date: DateTime(2020, 2, 14),
        category: Category('Shopping')),
    Transaction(
      id: 5,
      title: 'فاتورة نت',
      amount: 250,
      date: DateTime(2020, 2, 12),
      category: Category('Bills'),
    ),
    Transaction(
      id: 6,
      title: 'فاتورة التليفون الأرضي',
      amount: 79,
      date: DateTime(2020, 2, 13),
      category: Category('Bills'),
    ),
    Transaction(
      id: 7,
      title: 'زيارات عائلية',
      amount: 150,
      date: DateTime(2020, 2, 11),
      category: Category('Others'),
    ),
    Transaction(
      id: 8,
      title: 'رحلة أسوان',
      amount: 250,
      date: DateTime(2020, 2, 10),
      category: Category('Travelling'),
    ),
  ];

  List<Transaction> loadTXList() {
    // TODO: implement  getting Plan Object list from the database
    return null;
  }
} // Manager class end
