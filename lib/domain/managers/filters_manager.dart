import 'package:flutter/foundation.dart';

import '../models/transaction.dart';

class FiltersManager with ChangeNotifier {
  // Singleton instance from Filters Manager class.
  static final instance = FiltersManager._();
  factory FiltersManager() => instance;
  FiltersManager._();

  // filters booleans
  bool _showIncomeTransactions = false;
  bool get showIncomeTransactions => _showIncomeTransactions;
  set showIncomeTransactions(value) {
    _showIncomeTransactions = value;
    notifyListeners();
  }

  bool _showExpensesTransactions = false;
  bool get showExpensesTransactions => _showExpensesTransactions;
  set showExpensesTransactions(value) {
    _showExpensesTransactions = value;
    notifyListeners();
  }

  // x-nor operation on the previous category filters
  // X-NOR Truth Table
  // 0 , 0 => 1 (default)
  // 0 , 1 => 0
  // 1 , 0 => 0
  // 1 , 1 => 1
  bool get _showAllTransactions =>
      !(_showExpensesTransactions ^ _showIncomeTransactions);

  // a filter function that returns a new filtered list
  // according to filters booleans
  List<Transaction> filter(List<Transaction> transactions) {
    final filteredList = _showAllTransactions
        ? transactions
        : _showIncomeTransactions
            ? transactions.where((tx) => tx.amount > 0)
            : transactions.where((tx) => tx.amount < 0);

    return filteredList.toList();
  }
}
