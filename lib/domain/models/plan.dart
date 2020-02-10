import './transaction.dart';
import './category.dart';
import './user.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:uuid/uuid.dart';

class Plan {
  final DateTime startDate;
  final double totalIncome;
  final User mainUser;
  final User secondaryUser;
  String id;

  Plan(
      {this.mainUser,
      this.secondaryUser,
      @required this.startDate,
      @required this.totalIncome}) {
    var uuid = Uuid();
    id = uuid.v1();
    print(id);
  }

  // List of Transactions , this should be empty and the user populate it
  List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'رواية الظل خارج الزمان',
        amount: 35,
        category: Category(category: Categories.Entertaining),
        date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'بطاطس',
      amount: 25,
      date: DateTime.now(),
      category: Category(category: Categories.Grocery),
    ),
    Transaction(
      id: 't3',
      title: 'تذكرة قطر',
      amount: 40,
      date: DateTime.now(),
      category: Category(category: Categories.Transportation),
    ),
    Transaction(
        id: 't4',
        title: 'كوتشي جديد',
        amount: 535,
        date: DateTime(2020, 2, 7),
        category: Category(category: Categories.Shopping)),
    Transaction(
      id: 't5',
      title: 'فاتورة نت',
      amount: 250,
      date: DateTime(2020, 2, 6),
      category: Category(category: Categories.Bills),
    ),
    Transaction(
      id: 't6',
      title: 'فاتورة التليفون الأرضي',
      amount: 79,
      date: DateTime(2020, 2, 3),
      category: Category(category: Categories.Bills),
    ),
    Transaction(
      id: 't7',
      title: 'زيارات عائلية',
      amount: 150,
      date: DateTime(2020, 2, 2),
      category: Category(category: Categories.Others),
    ),
    Transaction(
      id: 't8',
      title: 'رحلة أسوان',
      amount: 250,
      date: DateTime(2020, 2, 2),
      category: Category(category: Categories.Travelling),
    ),
  ];
}
