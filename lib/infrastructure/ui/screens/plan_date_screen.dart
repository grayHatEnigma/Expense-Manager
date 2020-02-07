import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';

import 'package:expense_manager/domain/manager_ui_contract.dart';

class PlanDateScreen extends StatefulWidget {
  @override
  _PlanDateScreenState createState() => _PlanDateScreenState();
}

class _PlanDateScreenState extends State<PlanDateScreen> {
  var chosenDate;
  String chosenDateText = 'No Date Chosen!';

  @override
  Widget build(BuildContext context) {
    final double totalIncome =
        ModalRoute.of(context).settings.arguments as double;
    final manager = Provider.of<ManagerUiContract>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (chosenDate != null) {
            manager.setPlan(startDate: chosenDate, totalIncome: totalIncome);

            Navigator.pushNamed(context, '/home');
          }
          //TODO: handle exception if user doesn't enter data
        },
        child: Icon(
          Icons.chevron_right,
          size: 40,
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'بتقبض يوم كام ؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.date_range,
                color: Colors.white,
                size: 60,
              ),
              onPressed: () async {
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
                    chosenDateText = 'Picked Date: ${formatDate(chosenDate, [
                      dd,
                      '/',
                      mm,
                    ])}';
                  });
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              chosenDateText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  letterSpacing: 3,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
