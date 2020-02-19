import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//my imports
import './infrastructure/ui/screens/plan_date_screen.dart';
import './infrastructure/ui/screens/analysis_screen.dart';
import './infrastructure/ui/screens/plan_salary_screen.dart';
import './infrastructure/ui/screens/intro_screen.dart';
import './infrastructure/ui/screens/home_screen.dart';
import './infrastructure/ui/screens/settings_screen.dart';
import './infrastructure/ui/screens/about_screen.dart';
import './constants.dart';
import './domain/managers/plan_manager.dart';
import './domain/managers/ui_manager.dart';
import './domain/managers/database_manager.dart';

// TODO: REFACTOR AND CLEAN THE CODE

void main() {
  // Run the app
  runApp(MyApp());

  // Read from the Database immediately after creating the app.
  DatabaseManager();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlanManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => UiManager(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          FlutterI18nDelegate(
              useCountryCode: false,
              fallbackFile: 'en.json',
              path: 'flutter_i18n'),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        debugShowCheckedModeBanner: false,
        title: kTitle,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Tajawal',
        ),
        routes: {
          kHomeScreenID: (context) => HomeScreen(),
          kAnalysisScreenID: (context) => AnalysisScreen(),
          kPlanSalaryScreenID: (context) => PlanSalaryScreen(),
          kPlanDateScreenID: (context) => PlanDateScreen(),
          kIntroScreenID: (context) => IntroScreen(),
          kAboutScreenID: (context) => AboutScreen(),
          kSettingsScreenID: (context) => SettingsScreen(),
        },
        initialRoute: kIntroScreenID,
      ),
    );
  }
}
