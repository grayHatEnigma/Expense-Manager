import 'package:flutter/material.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domain/managers/ui_manager.dart';
import './analysis_details_screen.dart';
import './analysis_screen.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final uiManager = Provider.of<UiManager>(context);

    final analysisDate = uiManager.analysisDate;

    String monthTag = DateFormat.MMMM(locale.languageCode).format(analysisDate);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${FlutterI18n.translate(context, kAnalysisTitle)} $monthTag',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () async {
                var userDate = await showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: DateTime.now());

                if (userDate != null) {
                  // update the chosen date on the screen
                  uiManager.analysisDate = userDate;
                }
              },
            )
          ],
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
