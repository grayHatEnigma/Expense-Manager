import 'dart:collection';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';
import './models/category.dart';

abstract class ManagerUiContract with ChangeNotifier {
  //List of transactions
  UnmodifiableListView<Transaction> get transactionsList;

  List<List<Transaction>> get groupedTransactionsByDate;

  // Recent spending and transactions
  List<Transaction> get lastWeekTransactions;
  List<ChartBar> get lastWeekSpendingByDay;

  // total spending for a list
  double calculateTotalSpending(List<Transaction> list);

  // Add , Remove a transaction
  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      Category category,
      String id});

  void deleteTransaction({int index, String id});
}
