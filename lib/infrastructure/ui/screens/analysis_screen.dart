import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../domain/managers/ui_manager.dart';
import '../widgets/pie_chart_widget.dart';
import '../widgets/gauge_widget.dart';

class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context);
    final length = uiManager.totalSpendingPerCategory().length;
    bool isEmpty = length == 0;

    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SafeArea(
      child: isLandscape
          ? SingleChildScrollView(
              child: Layout(
                size: MainAxisSize.min,
                isEmpty: isEmpty,
              ),
            )
          : Layout(
              isEmpty: isEmpty,
            ),
    );
  }
}

class Layout extends StatelessWidget {
  final MainAxisSize size;
  final bool isEmpty;
  Layout({this.size = MainAxisSize.max, this.isEmpty = false});
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
        if (!isEmpty)
          Flexible(
            flex: 1,
            child: GaugeWidget(),
          ),
      ],
    );
  }
}
