import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

import '../widgets/pie_chart_widget.dart';
import '../widgets/gauge_widget.dart';
import '../../../constants.dart';

// TODO: fix orientation problems in this screen
class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            kTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (!isLandscape)
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    FlutterI18n.translate(context, kAnalysisTitle),
                    style: TextStyle(fontSize: 25),
                  ),
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
