import 'package:flutter/material.dart';

/// This class serves as a simple constants provider across the entire app.

//Screen IDs
const String kHomeScreenID = '/home';
const String kAnalysisScreenID = '/analysis';
const String kPlanSalaryScreenID = '/plan_salary';
const String kPlanDateScreenID = '/plan_date';
const String kIntroScreenID = '/intro';
const String kSettingsScreenID = '/settings';
const String kSettingsChoiceScreenID = '/setteings_choice';
const String kAboutScreenID = '/about';

// App Title
const kTitle = 'الفلوس راحت فين؟';

// Plan Screens Texts Keys
const kSalaryInputText = "Enter Your Salary";
const kSalaryToastMsg = "enter your salary first";
const kDateInputText = "Plan Starting Date";
const kDateToastMsg = "pick your plan date";
const kDateInputDescription = "plan will be renewed monthly on";

// Analysis Screen Texts Keys
const kAnalysisTitle = "Expenses Analysis";
const kAnalysisGaugeTitle = "Total Expenses";
const kAnalysisLimitTitle = "You Spent All Your Money";

// Add Transaction Screen Texts Keys
const kTitleTextFieldHint = "Title";
const kAmountTextFieldHint = "Amount";
const kDropDownMenuHint = "Choose Category";
const kPickDateButton = "Pick Date";
const kChosenDateText = "No Date Chosen";
const kAddButton = "Add";

// About Screen Texts Keys
const kDeveloperText = "This app was developed by";
const kDesignerText = "Icons in this app made by Darius Dan";

// Settings Screen Texts Keys
const kSettingsTitle = "Settings";
const kSalaryButton = "Edit Salary";
const kPlanDateButton = "Edit Plan Date";
const kResetButton = "Reset";
const kConfirmButton = "Confirm";
const kCancelButton = "Cancel";
const kResetMsg = "Are You Sure You Want To Delete All Your Records?";

// HomeScreen/AdaptiveSwitch Text Key
const kShowChartButton = "Show Chart";

// Transactions Card Texts Keys
const kDailyExpenses = "Expenses";

// Transactions Tile and Chart Bar Widget Texts Keys
const kMoneyPrefix = "EG";
const kDeleteButtonHint = "Delete";

// Navigation Drawer Texts Keys
const kNavAnalysis = "Analysis";
const kNavSettings = "Settings";
const kNavAbout = "About";
const kNavRate = "Rate Us";

// No Transactions Widget Text Key
const kEmptyList = "No Transactions Added Yet";

// Styles
const kChartTextStyle = TextStyle(color: Colors.white, fontSize: 15);
const kTitleTextStyle = TextStyle(
  fontSize: 23,
  color: Colors.white,
);
