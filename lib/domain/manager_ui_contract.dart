import 'dart:collection';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';
import './models/category.dart';
import './models/plan.dart';

/// UI Contract ( Interface )
/// this contract provide what the 'ui module'  need from the 'database module'

abstract class ManagerUiContract with ChangeNotifier {
  /*
  Plan
  */
  void createPlan({DateTime startDate, double totalIncome});
  Plan get plan;
  bool get hasPlan;

  /*
  Lists of Transactions
  */
  // Grouped lists of transactions by date
  List<List<Transaction>> get groupedTransactionsByDate;

  // Recent (last week) transactions and spending for each day of the last week
  List<Transaction> get lastWeekTransactions;
  List<ChartBar> get lastWeekSpendingByDay;

  // Transactions list for a certain time period
  List<Transaction> recentTransactions({int differenceInDays});

  // Calculate total spending for a given list
  double calculateTotalSpending(List<Transaction> list);

  // Group - required - transactions list by category,
  // and then calculate total spending in each category
  Map<Category, double> totalSpendingPerCategory(
      List<Transaction> requiredTransactionsList);

  /*
  Add , Remove a transaction
  */
  void addTransaction(
      {String title, double amount, DateTime date, Category category});

  void deleteTransaction({int index, int id});
}
