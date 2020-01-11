import 'dart:collection';
import 'package:flutter/widgets.dart';
import './transaction.dart';
import './chart_bar.dart';
import 'package:date_format/date_format.dart';

class TransactionsData with ChangeNotifier {
  /// List of Transactions
  List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'رواية الظل خارج الزمان',
        amount: 35,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'سندوتش بروست', amount: 25, date: DateTime.now()),
    Transaction(id: 't3', title: 'تذكرة قطر', amount: 40, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'كوتشي جديد', amount: 565, date: DateTime(2020, 1, 8)),
    Transaction(
        id: 't4',
        title: 'بنطلون جديد',
        amount: 250,
        date: DateTime(2020, 1, 7)),
  ];

  /// Recent Transactions ( Last week ) .
  // a function to get the last week transactions

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return (DateTime.now().difference(tx.date).inDays < 7);
    }).toList();
  }

// a function to get the total spending amount during the last week
  double get totalRecentSpending {
    double total = 0;
    _recentTransactions.forEach((tx) {
      total += tx.amount;
    });
    return total;
  }

  // a function to get transactions that are grouped by day of the week
  List<ChartBar> get groupedTransactions {
    return List.generate(7, (index) {
      final currentDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      _recentTransactions.forEach((tx) {
        if (tx.date.day == currentDay.day &&
            tx.date.month == currentDay.month &&
            tx.date.year == currentDay.year) {
          totalSum += tx.amount;
        }
      });
      return ChartBar(weekDay: formatDate(currentDay, [D]), amount: totalSum);
    });
  }

  /// Unmodified Version Of our transactions list
  UnmodifiableListView<Transaction> get transactionsList =>
      UnmodifiableListView(_transactions);

  /// Add and Delete Transactions

  // Add a new transaction to the list
  void addTransaction({String title, double amount, DateTime date, String id}) {
    // add a new transaction
    _transactions.add(
      Transaction(title: title, amount: amount, date: date, id: id),
    );
    notifyListeners();
  }

  // Delete an existing transaction from the list
  void deleteTransaction(int index) {
    _transactions.removeAt(index);
    notifyListeners();
  }
} // TransactionsData class end
