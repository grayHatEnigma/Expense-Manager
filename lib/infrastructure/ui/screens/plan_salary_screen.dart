import 'package:flutter/material.dart';

class PlanSalaryScreen extends StatefulWidget {
  @override
  _PlanSalaryScreenState createState() => _PlanSalaryScreenState();
}

class _PlanSalaryScreenState extends State<PlanSalaryScreen> {
  final incomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (incomeController.text != null) {
            double income = double.parse(incomeController.text);
            incomeController.clear();
            Navigator.pushNamed(context, '/plan_date', arguments: income);
          }
          //TODO: handle exception if user doesn't enter data  / show a toast
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
              'دخلك الشهري كام؟',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                ),
                style: TextStyle(color: Colors.white, fontSize: 30),
                controller: incomeController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    incomeController.dispose();
  }
}
