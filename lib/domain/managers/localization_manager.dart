import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// this class is responsible of loading user preferred language at each start.

class LocalizationManager with ChangeNotifier {
  // singleton pattern
  static final instance = LocalizationManager._();
  LocalizationManager._() {
    // read plan values from shared preferences
    // as soon  as the object is created
    _readFromSharedPreferences();
  }

  factory LocalizationManager() => instance;

  Locale preferredLocale;

  set setPreferredLocale(Locale locale) {
    preferredLocale = locale;
    _saveToSharedPreferences(locale.languageCode);
    notifyListeners();
  }

  Future<bool> _readFromSharedPreferences() async {
    final shared = await _sharedPreferences;

    final preferredLanguage = shared.getString('languageCode');
    if (preferredLanguage != null) {
      preferredLocale = Locale(preferredLanguage);
      notifyListeners();
      return true;
    }
    return false;
  }

  void _saveToSharedPreferences(String languageCode) async {
    final shared = await _sharedPreferences;
    await shared.setString('languageCode', languageCode);
  }

  Future<SharedPreferences> get _sharedPreferences async =>
      await SharedPreferences.getInstance();
}
