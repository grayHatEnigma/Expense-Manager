import 'package:flutter/material.dart';

class Category {
  String _title;
  Color _color;

  Category(this._title);
  Category.fromEnum(Categories type) {
    final typeTitle = type.toString().split('.').last;
    _title = typeTitle;
    _color = color;
  }

  // Encode and Decode a Category object

  // a method to convert Category object to String
  String encodeToString() {
    return '$title.${color.value}';
  }

  // a constructor to create a category object back  from string
  Category.decodeFromString(String encodedCategory) {
    _title = encodedCategory.split('.').first;
    _color = Color(int.parse(encodedCategory.split('.').last));
  }

  // getters for title and color
  String get title => _title ?? 'Others';
  Color get color {
    if (_color != null) {
      return _color;
    }
    Color categoryColor;
    switch (title) {
      case 'Savings':
        categoryColor = Colors.green;
        break;
      case 'Books':
        categoryColor = Colors.cyan;
        break;
      case 'Education':
        categoryColor = Colors.teal;
        break;
      case 'Entertaining':
        categoryColor = Colors.indigo;
        break;
      case 'Maintenance':
        categoryColor = Colors.blue;
        break;
      case 'Bills':
        categoryColor = Colors.lightBlue;
        break;
      case 'Transportation':
        categoryColor = Colors.lightBlueAccent;
        break;
      case 'Shopping':
        categoryColor = Colors.pink;
        break;
      case 'Makeup':
        categoryColor = Colors.pinkAccent;
        break;
      case 'Emergency':
        categoryColor = Colors.red;
        break;
      case 'Grocery':
        categoryColor = Colors.redAccent;
        break;
      case 'Children':
        categoryColor = Colors.orange;
        break;
      case 'Medicine':
        categoryColor = Colors.deepOrange;
        break;
      case 'Travelling':
        categoryColor = Colors.brown;
        break;
      case 'Others':
        categoryColor = Colors.grey;
        break;
      default:
        {
          categoryColor = Colors.grey;
        }
        break;
    }

    return categoryColor;
  }
}

// List Of Categories
enum Categories {
  Bills,
  Books,
  Education,
  Savings,
  Makeup,
  Children,
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
