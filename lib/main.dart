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
import 'package:expense_manager/constants.dart';

//TODO: REFACTOR AND CLEAN THE CODE

void main() {
  //To make sure it reads the shared preferences first .
  WidgetsFlutterBinding.ensureInitialized();
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
        title: kTitle,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Tajawal',
        ),
        routes: {
          kHomeScreenID: (context) => HomeScreen(title: kTitle),
          kAnalysisScreenID: (context) => AnalysisScreen(title: kTitle),
          kPlanSalaryScreenID: (context) => PlanSalaryScreen(),
          kPlanDateScreenID: (context) => PlanDateScreen(),
          kIntroScreenID: (context) => IntroScreen(title: kTitle),
        },
        initialRoute: kIntroScreenID,
      ),
    );
  }
}
