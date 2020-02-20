import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Plan {
  DateTime startDate;
  double totalIncome;

  Plan({@required this.startDate, @required this.totalIncome});

  String get planDateText => DateFormat.MMMd().format(startDate);
}
