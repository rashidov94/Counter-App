import 'package:flutter/material.dart';

import 'app_localization.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String RUSSIAN = 'ru';
const String UZBEK = 'uz';

Locale locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'EN');
    case RUSSIAN:
      return Locale(RUSSIAN, "RU");
    case UZBEK:
      return Locale(UZBEK, "UZ");
    default:
      return Locale(ENGLISH, 'EN');
  }
}

String? getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)!.translate(key);
}
