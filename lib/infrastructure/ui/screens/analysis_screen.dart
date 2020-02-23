import 'package:flutter/material.dart';

import '../widgets/pie_chart_widget.dart';
import '../widgets/gauge_widget.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SafeArea(
      child: isLandscape
          ? SingleChildScrollView(
              child: Layout(
                size: MainAxisSize.min,
              ),
            )
          : Layout(),
    );
  }
}

class Layout extends StatelessWidget {
  final MainAxisSize size;
  Layout({this.size = MainAxisSize.max});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: size,
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
          ),
        ),
      ],
    );
  }
}
