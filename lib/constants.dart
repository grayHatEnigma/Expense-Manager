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

// Navigation Drawer Texts
final kNavAnalysis = 'تحليل المصاريف';
final kNavSettings = 'الإعدادات';
final kNavAbout = 'عن التطبيق';
final kNavRate = 'قيّم التطبيق';

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
