import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/plan.dart';

/// Handle Reading and Saving Plan to Shared Preferences

class PlanManager with ChangeNotifier {
  static final instance = PlanManager._();
  PlanManager._() {
    // read plan values from shared preferences
    // as soon  as the object is created
    _readFromSharedPreferences();
  }

  factory PlanManager() => instance;

  Plan _plan;
  Plan get plan {
    return (_plan != null) ? _plan : throw 'Plan Not Found';
  }

  Future<bool> get hasPlan => _readFromSharedPreferences();

  // check plan date each time the app is lunched
  void _checkPlanDate() {
    final today = DateTime.now();
    if (_plan != null) {
      bool updatePlanDate = (_plan.startDate.day == today.day &&
          (today.month - _plan.startDate.month == 1));
      if (updatePlanDate) {
        _plan.startDate = DateTime.now();
        _saveToSharedPreferences(_plan.startDate, _plan.totalIncome);
      }
    }
  }

  // update or edit Plan.
  void updateOrEditPlan({DateTime newPlanDate, double newPlanIncome}) {
    // TODO: edit plan function.
    // update only the given parameter of this method.
  }

  void createPlan(
      {@required DateTime startDate, @required double totalIncome}) {
    if (_plan == null) {
      _plan = Plan(startDate: startDate, totalIncome: totalIncome);

      // save the new plan to shared preferences
      _saveToSharedPreferences(startDate, totalIncome);
    }
  }

  // get shared preferences object
  Future<SharedPreferences> get _sharedPreferences async =>
      await SharedPreferences.getInstance();

  // to save the plan values in shared preferences
  void _saveToSharedPreferences(DateTime date, double income) async {
    final shared = await _sharedPreferences;

    await shared.setString('startDate', date.toString());
    await shared.setDouble('totalIncome', income);
  }

  // to read plan values from shared preferences if existed
  Future<bool> _readFromSharedPreferences() async {
    return _sharedPreferences.then((prefs) {
      final dateString = prefs.getString('startDate');
      final income = prefs.getDouble('totalIncome');

      if (dateString != null && income != null) {
        print('plan date : $dateString  , plan income : $income');

        // check plan date
        _checkPlanDate();
        DateTime startDate = DateTime.parse(dateString);
        double totalIncome = income;
        createPlan(startDate: startDate, totalIncome: totalIncome);
        return true;
      }
      return false;
    });
  }
} //PlanManager
