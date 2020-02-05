import 'dart:collection';
import 'package:expense_manager/domain/models/category.dart';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';

abstract class ManagerUiContract with ChangeNotifier {
  //List of transactions
  UnmodifiableListView<Transaction> get transactionsList;

  List<List<Transaction>> get groupedTransactionsByDate;

  // Recent spending and transactions
  double get lastWeekTotalSpending;
  List<ChartBar> get lastWeekSpendingByDay;

  // Add , Remove a transaction
  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      Category category,
      String id});

  void deleteTransaction({int index, String id});
}
