import 'package:flutter/material.dart';

import '../widgets/pie_chart_widget.dart';
import '../widgets/gauge_widget.dart';

// TODO: fix orientation problems in this screen
class AnalysisScreen extends StatelessWidget {
  final String title;
  AnalysisScreen({this.title});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (!isLandscape)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'مصاريفك',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            Flexible(
              flex: 2,
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
