import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../../constants.dart';
import '../../../domain/managers/plan_manager.dart';

class PlanDateScreen extends StatefulWidget {
  @override
  _PlanDateScreenState createState() => _PlanDateScreenState();
}

class _PlanDateScreenState extends State<PlanDateScreen> {
  var chosenDate;
  String chosenDateText = '';

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final double totalIncome = route.settings.arguments as double;
    final planManager = Provider.of<PlanManager>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (chosenDate != null) {
            planManager.createPlan(
                startDate: chosenDate, totalIncome: totalIncome);

            // remove the route below this.
            Navigator.removeRouteBelow(context, route);
            // navigate to home screen.
            Navigator.pushReplacementNamed(context, kHomeScreenID);
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
        },
        child: Icon(
          Icons.arrow_forward,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, kDateInputText),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            SizedBox(
              height: 20,
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
                    chosenDateText = '${formatDate(chosenDate, [
                      d,
                    ])}';
                  });
                }
              },
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '${FlutterI18n.translate(context, kDateInputDescription)}\n$chosenDateText',
              textAlign: TextAlign.center,
              style: TextStyle(letterSpacing: 3, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
