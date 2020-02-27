import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../domain/managers/filters_manager.dart';
import '../../../constants.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    // filters manager instance to set filters
    final filtersManager = Provider.of<FiltersManager>(context);

    //

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          FlutterI18n.translate(context, kFiltersScreenTitle),
          style: kAppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/calendar.png',
                  height: 25,
                  width: 25,
                ),
                Flexible(
                  child: SwitchListTile(
                    title: Text(
                      FlutterI18n.translate(context, kDateSwitch),
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      FlutterI18n.translate(context, kDateSwitchSubtitle),
                    ),
                    value: filtersManager.showCurrentMonth,
                    onChanged: (newValue) {
                      setState(() {
                        filtersManager.showCurrentMonth = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/income.png',
                  height: 25,
                  width: 25,
                ),
                Flexible(
                  child: SwitchListTile(
                    title: Text(
                      FlutterI18n.translate(context, kIncomeSwitch),
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      FlutterI18n.translate(context, kIncomeSwitchSubtitle),
                    ),
                    value: filtersManager.showIncomeTransactions,
                    onChanged: (newValue) {
                      setState(() {
                        filtersManager.showIncomeTransactions = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/expenses.png',
                  height: 25,
                  width: 25,
                ),
                Flexible(
                  child: SwitchListTile(
                    title: Text(
                      FlutterI18n.translate(context, kExpensesSwitch),
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      FlutterI18n.translate(context, kExpensesSwitchSubtitle),
                    ),
                    value: filtersManager.showExpensesTransactions,
                    onChanged: (newValue) {
                      setState(() {
                        filtersManager.showExpensesTransactions = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
