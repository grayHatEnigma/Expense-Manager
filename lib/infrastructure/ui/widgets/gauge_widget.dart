import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';

class GaugeWidget extends StatefulWidget {
  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    final int range =
        DateTime.now().difference(manager.getPlan().startDate).inDays;

    final double totalExpenses = manager.calculateTotalSpending(
        manager.recentTransactions(differenceInDays: range));
    final double totalIncome = manager.getPlan().totalIncome;
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            FlutterGauge(
              start: 0,
              end: totalIncome.toInt(),
              circleColor: Colors.white,
              inactiveColor: Colors.purple,
              activeColor: Colors.amber,
              handColor: Colors.amber,
              numberInAndOut: NumberInAndOut.inside,
              handSize: 5,
              index: totalExpenses,
              hand: Hand.long,
              number: Number.endAndCenterAndStart,
              secondsMarker: SecondsMarker.minutes,
              counterStyle: TextStyle(
                color: Colors.amber,
                fontSize: 25,
              ),
            ),
            Text(
              'Total Expenses: ${totalExpenses.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
