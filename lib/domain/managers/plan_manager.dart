import 'package:expense_manager/domain/managers/database_manager.dart';
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
    return hasPlan ? _plan : throw 'Plan Not Found';
  }

  bool get hasPlan => _plan != null;

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

    shared.setString('startDate', date.toString());
    shared.setDouble('totalIncome', income);
  }

  // to read plan values from shared preferences if existed
  void _readFromSharedPreferences() async {
    final shared = await _sharedPreferences;
    final dateString = shared.getString('startDate');
    final income = shared.getDouble('totalIncome');

    if (dateString != null && income != null) {
      print('plan date : $dateString  , plan income : $income');
      DateTime startDate = DateTime.parse(dateString);
      double totalIncome = income;
      createPlan(startDate: startDate, totalIncome: totalIncome);
    }
  }
} //PlanManager
