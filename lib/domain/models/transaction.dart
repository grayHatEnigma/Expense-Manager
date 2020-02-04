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
      this.category = Category.OTHERS,
      this.date});

  Color get categoryColor {
    Color transactionColor;
    switch (category) {
      case Category.TRAVELLING:
        transactionColor = Colors.pinkAccent;
        break;
      case Category.ENTERTAINING:
        transactionColor = Colors.black;
        break;
      case Category.BILLS:
        transactionColor = Colors.red[700];
        break;
      case Category.GROCERY:
        transactionColor = Colors.redAccent;
        break;
      case Category.MEDICINE:
        transactionColor = Colors.deepOrange;
        break;
      case Category.MAINTENANCE:
        transactionColor = Colors.blue;
        break;
      case Category.TRANSPORTATION:
        transactionColor = Colors.lightBlue;
        break;
      case Category.SHOPPING:
        transactionColor = Colors.pink[400];
        break;
      case Category.EMERGENCY:
        transactionColor = Colors.yellow;
        break;
      case Category.OTHERS:
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
