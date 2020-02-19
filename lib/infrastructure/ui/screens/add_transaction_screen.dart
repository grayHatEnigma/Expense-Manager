//flutter core
import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

//my imports
import '../../../domain/models/category.dart';
import '../../../domain/managers/ui_manager.dart';
import '../../../constants.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String chosenDateText = kChosenDateText;
  //fields chosen by user and their default values in case he doesn't enter any
  DateTime chosenDate = DateTime.now();
  String chosenCategory;

  @override
  Widget build(BuildContext context) {
    final uiManager = Provider.of<UiManager>(context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: kTitleTextFieldHint),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: kAmountTextFieldHint),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  items: categories.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      chosenCategory = newValue;
                    });
                  },
                  value: chosenCategory,
                  hint: Text(
                    kDropDownMenuHint,
                    textAlign: TextAlign.start,
                  ),
                  icon: Icon(
                    Icons.assignment,
                    color: Theme.of(context).accentColor,
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                  ),
                  isExpanded: false,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  chosenDateText,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                FlatButton(
                    child: Text(
                      kPickDateButton,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () async {
                      var userDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );

                      if (userDate != null) {
                        // update the chosen date on the screen
                        setState(() {
                          chosenDate = userDate;
                          chosenDateText = '${formatDate(chosenDate, [
                            DD,
                            ' , ',
                            dd,
                            '/',
                            mm,
                            '/',
                            yy,
                          ])}';
                        });
                      }
                    }),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                kAddButton,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                double inputAmount = 0;
                try {
                  inputAmount = double.parse(amountController.text);
                } catch (e) {
                  print('Invaild amount input');
                }
                if (inputAmount > 0 && titleController.text.isNotEmpty) {
                  uiManager.addTransaction(
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    date: chosenDate,
                    category: Category(chosenCategory),
                  );

                  // clear the controllers
                  amountController.clear();
                  titleController.clear();

                  // pop the bottom sheet
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    // dispose the text fields controllers
    amountController.dispose();
    titleController.dispose();
  }
}
