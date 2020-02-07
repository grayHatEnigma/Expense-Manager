import 'package:flutter/material.dart';

class Category {
  final Type type;
  Category({this.type});

  String get title => type.toString().split('.').last;
  Color get color {
    Color categoryColor;
    switch (type) {
      case Type.Travelling:
        categoryColor = Colors.green;
        break;
      case Type.Entertaining:
        categoryColor = Colors.black;
        break;
      case Type.Bills:
        categoryColor = Colors.red[700];
        break;
      case Type.Grocery:
        categoryColor = Colors.redAccent;
        break;
      case Type.Medicine:
        categoryColor = Colors.deepOrange;
        break;
      case Type.Maintenance:
        categoryColor = Colors.blue;
        break;
      case Type.Transportation:
        categoryColor = Colors.lightBlue;
        break;
      case Type.Shopping:
        categoryColor = Colors.pink[400];
        break;
      case Type.Emergency:
        categoryColor = Colors.yellow;
        break;
      case Type.Others:
        categoryColor = Colors.grey;
        break;
    }

    return categoryColor;
  }
}

enum Type {
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
