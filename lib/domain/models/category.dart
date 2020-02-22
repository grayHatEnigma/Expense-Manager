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
        categoryColor = Colors.purple;
        break;
      case 'Education':
        categoryColor = Colors.teal;
        break;
      case 'Entertaining':
        categoryColor = Colors.indigo;
        break;
      case 'Maintenance':
        categoryColor = const Color(0xff404f24);
        break;
      case 'Bills':
        categoryColor = Colors.blue;
        break;
      case 'Transportation':
        categoryColor = Colors.black;
        break;
      case 'Shopping':
        categoryColor = const Color(0xff00344d);
        break;
      case 'Makeup':
        categoryColor = Colors.pinkAccent;
        break;
      case 'Emergency':
        categoryColor = Colors.red;
        break;
      case 'Grocery':
        categoryColor = Colors.brown;
        break;
      case 'Children':
        categoryColor = Colors.amber;
        break;
      case 'Medical':
        categoryColor = const Color(0xff57527e);
        break;
      case 'Travelling':
        categoryColor = const Color(0xff892034);
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
  Medical,
  Others,
  Shopping,
  Transportation,
  Travelling,
}
