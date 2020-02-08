import '../widgets/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/gauge_widget.dart';

class AnalysisScreen extends StatefulWidget {
  final String title;
  AnalysisScreen({this.title});
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'مصاريفك',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: PieChartWidget(),
              ),
            ),
            SizedBox(
              height: 10,
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
