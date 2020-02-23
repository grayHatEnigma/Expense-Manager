import 'package:expense_manager/infrastructure/ui/screens/analysis_details_screen.dart';
import 'package:expense_manager/infrastructure/ui/screens/analysis_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domain/managers/plan_manager.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planManager = Provider.of<PlanManager>(context);
    final locale = Localizations.localeOf(context);
    String monthTag =
        DateFormat.MMMM(locale.languageCode).format(planManager.plan.startDate);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${FlutterI18n.translate(context, kAnalysisTitle)} $monthTag',
          ),
          bottom: TabBar(
            indicatorWeight: 3.5,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.pie_chart),
                text: FlutterI18n.translate(context, kChartTitle),
              ),
              Tab(
                icon: Icon(Icons.assignment),
                text: FlutterI18n.translate(context, kAnalysisDetailsTitle),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AnalysisScreen(),
            AnalysisDetailsScreen(),
          ],
        ),
      ),
    );
  }
}
