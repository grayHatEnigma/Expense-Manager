import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../domain/managers/ui_manager.dart';
import '../../../domain/managers/plan_manager.dart';
import '../../../constants.dart';

class GaugeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planManager = Provider.of<PlanManager>(context);
    final uiManager = Provider.of<UiManager>(context);
    final int range =
        DateTime.now().difference(planManager.plan.startDate).inDays;

    final double totalExpenses = uiManager.calculateTotalSpending(
        uiManager.recentTransactions(rangeInDays: range));
    final double totalIncome = planManager.plan.totalIncome;
    final double percentage = totalExpenses / totalIncome;

    bool limitPassed = totalExpenses > totalIncome;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '${FlutterI18n.translate(context, kAnalysisGaugeTitle)} : ${totalExpenses.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 17,
            ),
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
                //textDirection: TextDirection.rtl,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          (percentage * 10),
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
                            (percentage * 10),
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

        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '${FlutterI18n.translate(context, kAnalysisGaugeBalance)} : ${(totalIncome - totalExpenses).toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 17,
            ),
          ),
        ),

        limitPassed
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  FlutterI18n.translate(context, kAnalysisLimitTitle),
                  style: TextStyle(fontSize: 17, color: Colors.red[700]),
                ),
              )
            : Container(),
      ],
    );
  }
}
