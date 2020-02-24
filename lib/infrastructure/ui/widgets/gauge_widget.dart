import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../domain/managers/ui_manager.dart';
import '../../../constants.dart';

class GaugeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);

    final double totalExpenses =
        uiManager.calculateTotalAmount(uiManager.analysisTransactions());
    final double totalIncome =
        uiManager.calculateTotalAmount(uiManager.incomeTransactions());
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: Chip(
            backgroundColor: Colors.green,
            elevation: 4,
            avatar: Image.asset('images/income.png'),
            label: Text(
              '${FlutterI18n.translate(context, kAnalysisIncomeTitle)} : ${totalIncome.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
        Flexible(
          child: Chip(
            backgroundColor: Colors.red,
            elevation: 4,
            avatar: Image.asset('images/expenses.png'),
            label: Text(
              '${FlutterI18n.translate(context, kAnalysisExpensesTitle)} : ${totalExpenses.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
        Flexible(
          child: Chip(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 4,
            avatar: Image.asset('images/balance.png'),
            label: Text(
              '${FlutterI18n.translate(context, kAnalysisBalanceTitle)} : ${(totalIncome - totalExpenses).toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
      ],
    );
  }
}
