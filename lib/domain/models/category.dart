import 'package:flutter/material.dart';

class Category {
  final Categories category;
  Category({this.category});

  String get title => category.toString().split('.').last;
  Color get color {
    Color categoryColor;
    switch (category) {
      case Categories.Travelling:
        categoryColor = Colors.green;
        break;
      case Categories.Entertaining:
        categoryColor = Colors.teal;
        break;
      case Categories.Bills:
        categoryColor = Colors.red[700];
        break;
      case Categories.Grocery:
        categoryColor = Colors.redAccent;
        break;
      case Categories.Medicine:
        categoryColor = Colors.deepOrange;
        break;
      case Categories.Maintenance:
        categoryColor = Colors.blue;
        break;
      case Categories.Transportation:
        categoryColor = Colors.lightBlue;
        break;
      case Categories.Shopping:
        categoryColor = Colors.pink[400];
        break;
      case Categories.Emergency:
        categoryColor = Colors.black;
        break;
      case Categories.Others:
        categoryColor = Colors.grey;
        break;
    }

    return categoryColor;
  }
}

enum Categories {
  Bills,
  Emergency,
  Entertaining,
  Grocery,
  Maintenance,
  Medicine,
  Others,
  Shopping,
  Transportation,
  Travelling,
}
