import 'dart:collection';
import 'package:expense_manager/domain/models/category.dart';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';

abstract class ManagerUiContract with ChangeNotifier {
  UnmodifiableListView<Transaction> get transactionsList;

  double get totalRecentSpending;

  List<ChartBar> get groupedTransactions;

  void addTransaction(
      {String title,
      double amount,
      DateTime date,
      Category category,
      String id});

  void deleteTransaction({int index, String id});
}
