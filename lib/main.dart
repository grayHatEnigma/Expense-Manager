import 'package:flutter/material.dart';

//external packages
import 'package:provider/provider.dart';

//my imports
import './infrastructure/ui/screens/plan_date_screen.dart';
import './domain/manager_ui_contract.dart';
import './infrastructure/ui/screens/analysis_screen.dart';
import './infrastructure/ui/screens/plan_salary_screen.dart';
import './infrastructure/ui/screens/intro_screen.dart';
import './domain/manager.dart';
import './infrastructure/ui/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ManagerUiContract _managerUiContract = Manager();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _managerUiContract,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'الفلوس راحت فين؟',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Tajawal',
        ),
        routes: {
          '/home': (context) => HomeScreen(title: 'الفلوس راحت فين؟'),
          '/analysis': (context) => AnalysisScreen(title: 'الفلوس راحت فين؟'),
          '/plan_salary': (context) => PlanSalaryScreen(),
          '/plan_date': (context) => PlanDateScreen(),
          '/intro': (context) => IntroScreen(title: 'الفلوس راحت فين؟'),
        },
        initialRoute: _managerUiContract.hasPlan ? '/home' : '/intro',
      ),
    );
  }
}
