import './category.dart';

class Transaction {
  final String id;
  final String title;
  final Category category;
  final double amount;
  final DateTime date;

  Transaction({this.id, this.title, this.amount, this.category, this.date});

  String get dayDate => '${date.day}${date.month}${date.year}';
  @override
  String toString() {
    return this.title;
  }
}
