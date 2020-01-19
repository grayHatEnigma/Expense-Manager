//flutter core
import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

//my imports
import '../models/chart_bar.dart';
import '../models/transactions_data.dart';
import './chart_bar_widget.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalRecentSpending =
        Provider.of<TransactionsData>(context).totalRecentSpending;
    final List<ChartBar> chartBars =
        Provider.of<TransactionsData>(context).groupedTransactions;

    return Card(
      elevation: 6,
      margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),
      color: Theme.of(context).primaryColorLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: chartBars
            .map((barData) {
              return Expanded(
                child: ChartBarWidget(
                  amount: barData.amount,
                  weekDay: barData.weekDay,
                  percentage: totalRecentSpending == 0.0
                      ? 0
                      : barData.amount / totalRecentSpending,
                ),
              );
            })
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
