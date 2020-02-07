import 'package:flutter/material.dart';
import 'package:expense_manager/domain/models/category.dart';
import '../widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';

class PieChartWidget extends StatefulWidget {
  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    final int range =
        DateTime.now().difference(manager.getPlan().startDate).inDays;
    final pieChartMap = manager.totalSpendingPerCategory(
        manager.recentTransactions(differenceInDays: range));
    final double totalExpenses = manager.calculateTotalSpending(
        manager.recentTransactions(differenceInDays: range));
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(touchCallback: (touchResponse) {
                      print(touchResponse.touchedSectionIndex);
                      setState(() {
                        touchedIndex = touchResponse.touchedSectionIndex;
                      });
                    }),
                    startDegreeOffset: 0,
                    sections: getSections(
                        pieChartMap: pieChartMap, totalWeight: totalExpenses),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 2,
                    centerSpaceRadius: 30,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    pieChartMap.entries.length,
                    (index) {
                      final Category category =
                          pieChartMap.entries.toList()[index].key;

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: Indicator(
                          color: category.color,
                          text: category.title,
                          isSquare: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Total Expenses: ${totalExpenses.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ); // PieChartSection;
  }

  List<PieChartSectionData> getSections({Map pieChartMap, double totalWeight}) {
    List<PieChartSectionData> pieChartList =
        List.generate(pieChartMap.entries.length, (index) {
      final Category category = pieChartMap.entries.toList()[index].key;
      final totalSpentInCategory = pieChartMap.entries.toList()[index].value;
      final isTouched = touchedIndex == index;
      final sectionWeight =
          ((totalSpentInCategory / totalWeight) * 100).round();
      return PieChartSectionData(
        radius: isTouched ? 75 : 60,
        titleStyle: TextStyle(
            fontSize: isTouched ? 18 : 12,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        titlePositionPercentageOffset: 0.65,
        showTitle: sectionWeight >= 3 ? true : false,
        value: totalSpentInCategory,
        title: '$sectionWeight %',
        color: category.color,
      );
    });

    // TODO: fix when there is no transaction yet
    return pieChartList;
  }
}
