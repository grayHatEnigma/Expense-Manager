import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../widgets/pie_chart_widget.dart';
import '../widgets/gauge_widget.dart';
import '../../../constants.dart';

// TODO: fix orientation problems in this screen
class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            FlutterI18n.translate(context, kAnalysisTitle),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: PieChartWidget(),
              ),
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GaugeWidget(),
                )),
          ],
        ),
      ),
    );
  }
}
