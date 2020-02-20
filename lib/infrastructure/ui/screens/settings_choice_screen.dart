import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domain/managers/plan_manager.dart';
import '../../../domain/managers/ui_manager.dart';

class SettingsChoiceScreen extends StatefulWidget {
  @override
  _SettingsChoiceScreenState createState() => _SettingsChoiceScreenState();
}

class _SettingsChoiceScreenState extends State<SettingsChoiceScreen> {
  final incomeController = TextEditingController();
  DateTime chosenDate;
  Color calendarColor = Colors.black;
  String planDateText;

  @override
  Widget build(BuildContext context) {
    final planManager = Provider.of<PlanManager>(context);
    final uiManager = Provider.of<UiManager>(context);
    final choice = ModalRoute.of(context).settings.arguments as Settings;

    if (planDateText == null) {
      planDateText = planManager.plan.planDateText;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            FlutterI18n.translate(context, kSettingsTitle),
            style: TextStyle(letterSpacing: 2),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (choice == Settings.edit_salary) editSalaryUi(),
            if (choice == Settings.edit_plan_date) editPlanDateUi(),
            if (choice == Settings.reset) resetAllTransactions(),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    FlutterI18n.translate(context, kCancelButton),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                    color: Colors.green,
                    child: Text(
                      FlutterI18n.translate(context, kConfirmButton),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      switch (choice) {
                        case Settings.edit_salary:
                          onEditSalary(planManager);
                          break;
                        case Settings.edit_plan_date:
                          onEditPlanDate(planManager);
                          break;
                        case Settings.reset:
                          onReset(uiManager);
                          break;
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget editSalaryUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, kSalaryInputText),
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                suffixIcon: Image.asset(
                  'images/gold.png',
                  height: 30,
                  width: 30,
                ),
              ),
              style: TextStyle(color: Colors.black, fontSize: 30),
              controller: incomeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget editPlanDateUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, kDateInputText),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              var userDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2040),
              );
              if (userDate != null) {
                // update the chosen date on the screen
                setState(() {
                  chosenDate = userDate;
                  calendarColor = Colors.green;

                  planDateText = DateFormat.MMMd().format(userDate);
                });
              }
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.date_range,
                color: calendarColor,
                size: 40,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${FlutterI18n.translate(context, kDateInputDescription)} : $planDateText',
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 3, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget resetAllTransactions() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        FlutterI18n.translate(context, kResetMsg),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red[700], fontSize: 20, fontStyle: FontStyle.italic),
      ),
    );
  }

  void onEditPlanDate(PlanManager planManager) {
    if (chosenDate != null) {
      print('new plan date $chosenDate');
      planManager.editPlan(newPlanDate: chosenDate);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: FlutterI18n.translate(context, kDateToastMsg),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 17.0);
    }
  }

  void onEditSalary(PlanManager planManager) {
    try {
      if (incomeController.text != null) {
        double income = double.parse(incomeController.text);
        incomeController.clear();
        print('new income $income');
        planManager.editPlan(newPlanIncome: income);
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: FlutterI18n.translate(context, kSalaryToastMsg),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 17.0);
    }
  }

  void onReset(UiManager uiManager) {
    uiManager.reset();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    incomeController.dispose();
    super.dispose();
  }
}

enum Settings { edit_salary, edit_plan_date, reset }
