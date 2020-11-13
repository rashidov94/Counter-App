import 'package:flutter/material.dart';

abstract class SharedPreferenceInterface {
  Future<Locale> setLocale(String languageCode);

  Future<Locale> getLocale();
}
