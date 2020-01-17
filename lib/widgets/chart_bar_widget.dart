import 'package:flutter/material.dart';
import '../constants.dart';

class ChartBarWidget extends StatelessWidget {
  final double amount;
  final String weekDay;
  final double percentage;

  ChartBarWidget({this.amount, this.weekDay, this.percentage});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: FittedBox(
              child: Text(
                weekDay,
                style: kChartTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            height: 60,
            width: 13,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 20,
            child: FittedBox(
              child: Text(
                '${amount.toStringAsFixed(0)} EG ',
                style: kChartTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
