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

// Plan Screens Texts Keys
final kSalaryInputText = 'kSalaryInputText';
final kSalaryToastMsg = 'kSalaryToastMsg';

final kDateInputText = 'kDateInputText';
final kDateToastMsg = 'kDateToastMsg';
final kDateInputDescription = 'kDateInputDescription';

// Analysis Screen Texts Keys
final kAnalysisTitle = 'kAnalysisTitle';
final kAnalysisGaugeTitle = 'kAnalysisGaugeTitle';
final kAnalysisLimitTitle = 'kAnalysisLimitTitle';

// Add Transaction Screen Texts Keys
final kTitleTextFieldHint = 'kTitleTextFieldHint';
final kAmountTextFieldHint = 'kAmountTextFieldHint';
final kDropDownMenuHint = 'kDropDownMenuHint';
final kPickDateButton = 'kPickDateButton';
final kChosenDateText = 'kChosenDateText';
final kAddButton = 'kAddButton';

// HomeScreen/AdaptiveSwitch Text Key
final kShowChartButton = 'kShowChartButton';

// Transactions Card Texts Keys
final kDailyExpenses = 'kDailyExpenses';

// Transactions Tile and Chart Bar Widget Texts Keys
final kMoneyPrefix = 'kMoneyPrefix';
final kDeleteButtonHint = 'kDeleteButtonHint';

// Navigation Drawer Texts Keys

final kNavAnalysis = 'kNavAnalysis';
final kNavSettings = 'kNavSettings';
final kNavAbout = 'kNavAbout';
final kNavRate = 'kNavRate';

// No Transactions Widget Text Key
final kEmptyList = 'kEmptyList';

// Styles
final kChartTextStyle = TextStyle(color: Colors.white, fontSize: 15);
final kTitleTextStyle = TextStyle(
  fontSize: 23,
  color: Colors.white,
);
