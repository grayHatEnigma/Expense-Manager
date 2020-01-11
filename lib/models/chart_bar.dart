class ChartBar {
  final String weekDay;
  final double amount;
  ChartBar({this.amount, this.weekDay});

  @override
  String toString() {
    return 'Day: $weekDay , Spent: $amount \$';
  }
}
