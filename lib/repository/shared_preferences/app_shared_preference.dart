import 'package:flutter/material.dart';
import 'package:flutter_app/localization/language_constants.dart';
import 'package:flutter_app/repository/shared_preferences/shared_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference implements SharedPreferenceInterface {
  final SharedPreferences _sharedPreferences;

  AppSharedPreference(this._sharedPreferences);

  @override
  String toString() {
    return _sharedPreferences.toString();
  }

  @override
  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(LANGUAGE_CODE, languageCode);
    return locale(languageCode);
  }

  @override
  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
    return locale(languageCode);
  }
}
