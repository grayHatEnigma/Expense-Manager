import 'package:flutter/material.dart';

class Category {
  String _title;
  Color _color;

  Category(this._title);

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
      case 'Travelling':
        categoryColor = Colors.green;
        break;
      case 'Entertaining':
        categoryColor = Colors.teal;
        break;
      case 'Bills':
        categoryColor = Colors.red[700];
        break;
      case 'Grocery':
        categoryColor = Colors.redAccent;
        break;
      case 'Medicine':
        categoryColor = Colors.deepOrange;
        break;
      case 'Maintenance':
        categoryColor = Colors.blue;
        break;
      case 'Transportation':
        categoryColor = Colors.lightBlue;
        break;
      case 'Shopping':
        categoryColor = Colors.pink[400];
        break;
      case 'Emergency':
        categoryColor = Colors.black;
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
// to add a new one you need to add here and in the switch statement above
// with the appropriate color
List<String> categories = [
  'Bills',
  'Emergency',
  'Entertaining',
  'Grocery',
  'Maintenance',
  'Medicine',
  'Others',
  'Shopping',
  'Transportation',
  'Travelling',
];
