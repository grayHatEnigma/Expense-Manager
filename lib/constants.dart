import 'package:flutter/material.dart';

/// This class serves as a simple constants provider across the entire app.

//Screen IDs
const String kHomeScreenID = '/home';
const String kAnalysisScreenID = '/analysis';
const String kPlanSalaryScreenID = '/plan_salary';
const String kPlanDateScreenID = '/plan_date';
const String kIntroScreenID = '/intro';

// App Title

final kTitle = 'الفلوس راحت فين؟';

// Analysis Screen Texts

final kAnalysisTitle = 'Expenses Analysis';
final kAnalysisGaugeTitle = 'Total Expenses';
final kAnalysisLimitTitle = 'You Spent All Your Money!';

// Add Transaction Screen Texts

final kTitleTextFieldHint = 'Title';
final kAmountTextFieldHint = 'Amount';
final kDropDownMenuHint = 'Choose Category ';
final kPickDateButton = 'Pick Date';
final kChosenDateText = 'No Date Chosen';
final kAddButton = 'Add';

// Transactions Card Texts
final kDailyExpenses = 'Expenses';

// Transactions Tile and Chart Bar Widget Texts
final kMoneyPrefix = 'EG';
final kDeleteButtonHint = 'Delete';

// Navigation Drawer Texts

final kNavAnalysis = 'Analysis';
final kNavSettings = 'Settings';
final kNavAbout = 'About';
final kNavRate = 'Rate Us';

// No Transactions Widget

final kNoTransactionsWidget = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.library_books,
        color: Colors.black38,
        size: 50,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'مضفتش أي مصروفات لسه!',
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black38,
          letterSpacing: 0.25,
        ),
      ),
    ],
  ),
);

// Styles

final kChartTextStyle = TextStyle(color: Colors.white, fontSize: 15);

final kTitleTextStyle = TextStyle(
  fontSize: 23,
  color: Colors.white,
);
