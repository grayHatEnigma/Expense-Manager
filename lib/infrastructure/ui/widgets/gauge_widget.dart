import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:expense_manager/domain/manager_ui_contract.dart';

class GaugeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    final int range =
        DateTime.now().difference(manager.getPlan().startDate).inDays;

    final double totalExpenses = manager.calculateTotalSpending(
        manager.recentTransactions(differenceInDays: range));
    final double totalIncome = manager.getPlan().totalIncome;
    final double percentage = totalExpenses / totalIncome;

    bool limitPassed = totalExpenses > totalIncome;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //
        Text(
          'إجمالي المصاريف: ${totalExpenses.toStringAsFixed(0)}',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '0',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15),
              ),
            ),
            Container(
              width: 200,
              height: 20,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          (15),
                        ),
                      ),
                    ),
                    width: 200,
                  ),
                  FractionallySizedBox(
                    widthFactor: limitPassed ? 1 : percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: limitPassed
                            ? Colors.red[700]
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            (15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        '${limitPassed ? 100 : (percentage * 100).toStringAsFixed(0)} %',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${totalIncome.toStringAsFixed(0)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15),
              ),
            ),
          ],
        ),
        limitPassed
            ? Text(
                'فلوسك طارت!',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 17, color: Colors.red[700]),
              )
            : Container(),
      ],
    );
  }
}
