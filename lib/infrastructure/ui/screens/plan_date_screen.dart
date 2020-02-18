import 'package:expense_manager/constants.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../domain/managers/plan_manager.dart';

class PlanDateScreen extends StatefulWidget {
  @override
  _PlanDateScreenState createState() => _PlanDateScreenState();
}

class _PlanDateScreenState extends State<PlanDateScreen> {
  var chosenDate;
  String chosenDateText = 'اختار تاريخ لخطتك';

  @override
  Widget build(BuildContext context) {
    final double totalIncome =
        ModalRoute.of(context).settings.arguments as double;
    final planManager = Provider.of<PlanManager>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (chosenDate != null) {
            planManager.createPlan(
                startDate: chosenDate, totalIncome: totalIncome);
            Navigator.pushReplacementNamed(context, kHomeScreenID);
          } else {
            Fluttertoast.showToast(
                msg: "ادخل تاريخ بداية خطة المصروفات",
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
              'بتقبض يوم كام؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, color: Colors.white),
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
                    chosenDateText =
                        'خطة المصروفات هتجدد تلقائياً يوم\n${formatDate(chosenDate, [
                      d,
                    ])} من كل شهر';
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
              chosenDateText,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(letterSpacing: 3, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
