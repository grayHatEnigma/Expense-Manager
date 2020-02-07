import 'package:flutter/foundation.dart';

class Plan {
  final String id;
  final DateTime startDate;
  final double totalIncome;

  Plan(
      {@required this.id,
      @required this.startDate,
      @required this.totalIncome});
}
