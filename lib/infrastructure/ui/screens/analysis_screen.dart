import '../widgets/pie_chart_widget.dart';
import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: PieChartWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
