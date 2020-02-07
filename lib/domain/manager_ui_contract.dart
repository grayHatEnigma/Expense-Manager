import 'dart:collection';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';
import './models/category.dart';
import './models/plan.dart';

abstract class ManagerUiContract with ChangeNotifier {
  // Plan
  void setPlan({DateTime startDate, double totalIncome});
  Plan getPlan();
  bool get hasPlan;
  //List of transactions
  UnmodifiableListView<Transaction> get transactionsList;

  List<List<Transaction>> get groupedTransactionsByDate;

  // Recent spending and transactions

  List<Transaction> get lastWeekTransactions;
  List<ChartBar> get lastWeekSpendingByDay;

  // a function to get  transactions list for a certain time
  List<Transaction> recentTransactions({int differenceInDays});
  // total spending for a list
  double calculateTotalSpending(List<Transaction> list);

  // a function that group - required - transactions by category
  Map<Category, double> totalSpendingPerCategory(
      List<Transaction> requiredTransactionsList);
  // Add , Remove a transaction
  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      Category category,
      String id});

  void deleteTransaction({int index, String id});
}
