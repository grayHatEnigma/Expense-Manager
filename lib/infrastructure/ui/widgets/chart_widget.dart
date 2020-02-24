import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

//my imports
import '../../../domain/managers/ui_manager.dart';
import '../../../domain/models/chart_bar.dart';
import './chart_bar_widget.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);
    final totalRecentSpending =
        uiManager.calculateTotalAmount(uiManager.lastWeekTransactions);
    final List<ChartBar> chartBars = uiManager.lastWeekSpendingPerDay;

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
