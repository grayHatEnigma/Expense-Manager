// TODO : this class will be responsible of handling user preferred  language

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalizationManager with ChangeNotifier {
  // singleton pattern
  static final instance = LocalizationManager._();
  LocalizationManager._() {
    // read plan values from shared preferences
    // as soon  as the object is created
  }

  factory LocalizationManager() => instance;

  Locale preferredLocale;

  set setPreferredLocale(Locale locale) {
    preferredLocale = locale;
    notifyListeners();
  }

  Future<bool> _readFromSharedPreferences() {
    // TODO: implement readFromSharedPreferences
    return null;
  }

  void _saveToSharedPreferences() {
    // TODO: implement saveToSharedPreferences
  }

  // TODO: implement sharedPreferences
  Future<SharedPreferences> get _sharedPreferences => null;
}
