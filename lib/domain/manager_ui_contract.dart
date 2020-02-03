import 'dart:collection';
import 'package:flutter/widgets.dart';

import './models/chart_bar.dart';
import './models/transaction.dart';

class ManagerUiContract with ChangeNotifier {
  // Unmodified Version Of our transactions list
  UnmodifiableListView<Transaction> get transactionsList => null;

  // a function to get the total spending amount during the last week
  double get totalRecentSpending {
    return 0;
  }

  // a function to get transactions that are grouped by day of the week
  List<ChartBar> get groupedTransactions {
    return null;
  }

  // Add a new transaction to the list
  void addTransaction(
      {String title, double amount, DateTime date, String id}) {}

  // Delete an existing transaction from the list
  void deleteTransaction({int index, String id}) {}
}
