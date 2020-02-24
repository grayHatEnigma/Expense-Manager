//flutter core

import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
  String chosenDateText;
  //fields chosen by user and their default values in case he doesn't enter any
  DateTime chosenDate = DateTime.now();
  var chosenCategory;
  Locale myLocale;

  // to check the category type
  bool chosenCategoryType;
  bool expenses = true;

  @override
  void didChangeDependencies() {
    /*
     * we did the initialization here cause we depend on an inherited widget
     * in our case Localization and this method is called each time the
     * dependencies changes  then the build method is called after it.
     *
    */
    myLocale = Localizations.localeOf(context);
    chosenDateText = DateFormat.yMEd(myLocale.languageCode).format(chosenDate);
    super.didChangeDependencies();
  }

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
              decoration: InputDecoration(
                  labelText:
                      FlutterI18n.translate(context, kTitleTextFieldHint)),
              controller: titleController,
              maxLength: 30,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText:
                      FlutterI18n.translate(context, kAmountTextFieldHint)),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            // Categories Drop Down Menu Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      activeColor: Colors.red,
                      value: true,
                      groupValue: expenses,
                      onChanged: (newVal) {
                        setState(() {
                          expenses = newVal;
                          chosenCategory = null;
                          print(expenses);
                        });
                      },
                    ),
                    Text(
                      'مصروفات',
                      style: TextStyle(color: Colors.red),
                    ),
                    Radio(
                      activeColor: Colors.green,
                      value: false,
                      groupValue: expenses,
                      onChanged: (newVal) {
                        setState(() {
                          expenses = newVal;
                          chosenCategory = null;
                          print(expenses);
                        });
                      },
                    ),
                    Text(
                      'دخل',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton(
                      items: expenses
                          ? ExpensesCategories.values.map((value) {
                              return DropdownMenuItem<ExpensesCategories>(
                                value: value,
                                child: Text(value.toText(context)),
                              );
                            }).toList()
                          : IncomeCategories.values.map((value) {
                              return DropdownMenuItem<IncomeCategories>(
                                value: value,
                                child: Text(value.toText(context)),
                              );
                            }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          chosenCategory = newValue;
                        });
                      },
                      value: chosenCategory,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          FlutterI18n.translate(context, kDropDownMenuHint),
                          textAlign: TextAlign.start,
                        ),
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
                    )),
              ],
            ),

            // Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  chosenDateText,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                FlatButton(
                    child: Text(
                      FlutterI18n.translate(context, kPickDateButton),
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
                          chosenDateText =
                              DateFormat.yMEd(myLocale.languageCode)
                                  .format(userDate);
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
                FlutterI18n.translate(context, kAddButton),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                double inputAmount = 0;
                try {
                  inputAmount = double.parse(amountController.text);
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: FlutterI18n.translate(context, kInvalidValueMsg),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 17.0);
                }
                if (inputAmount > 0 && titleController.text.isNotEmpty) {
                  uiManager.addTransaction(
                    title: titleController.text,
                    amount: expenses
                        ? -1 * double.parse(amountController.text)
                        : double.parse(amountController.text),
                    date: chosenDate,
                    category: Category.fromEnum(
                        chosenCategory ?? ExpensesCategories.Others),
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

// Translate Category
extension on ExpensesCategories {
  String toText(BuildContext context) {
    final categoryTitle = this.toString().split('.').last;
    return FlutterI18n.translate(context, categoryTitle);
  }
}

extension on IncomeCategories {
  String toText(BuildContext context) {
    final categoryTitle = this.toString().split('.').last;
    return FlutterI18n.translate(context, categoryTitle);
  }
}
