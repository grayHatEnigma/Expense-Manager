import './category.dart';
import '../../infrastructure/database/database_helper.dart';

class Transaction {
  int id;
  String title;
  Category category;
  double amount;
  DateTime date;

  Transaction({this.id, this.title, this.amount, this.category, this.date});

  String get dayDate => '${date.day}${date.month}${date.year}';
  String get monthDate => '${date.month}${date.year}';
  // Database related methods
  // convenience constructor to create a Transaction object
  Transaction.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    amount = map[columnAmount];

    // decode the category string into a Category object
    category = Category.decodeFromString(map[columnCategory]);

    // decode the date string into a DateTime object
    date = DateTime.parse(map[columnDate]);
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnAmount: amount,

      // encode the Category object into a string
      columnCategory: category.encodeToString(),

      // encode the DateTime object into a string
      columnDate: date.toString(),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
