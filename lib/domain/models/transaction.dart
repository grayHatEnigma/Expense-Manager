import './category.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final Category category;
  final double amount;
  final DateTime date;

  Transaction(
      {this.id,
      this.title,
      this.amount,
      this.category = Category.Others,
      this.date});

  Color get categoryColor {
    Color transactionColor;
    switch (category) {
      case Category.Travelling:
        transactionColor = Colors.green;
        break;
      case Category.Entertaining:
        transactionColor = Colors.black;
        break;
      case Category.Bills:
        transactionColor = Colors.red[700];
        break;
      case Category.Grocery:
        transactionColor = Colors.redAccent;
        break;
      case Category.Medicine:
        transactionColor = Colors.deepOrange;
        break;
      case Category.Maintenance:
        transactionColor = Colors.blue;
        break;
      case Category.Transportation:
        transactionColor = Colors.lightBlue;
        break;
      case Category.Shopping:
        transactionColor = Colors.pink[400];
        break;
      case Category.Emergency:
        transactionColor = Colors.yellow;
        break;
      case Category.Others:
        transactionColor = Colors.grey;
        break;
    }

    return transactionColor;
  }

  @override
  String toString() {
    return this.title;
  }
}
