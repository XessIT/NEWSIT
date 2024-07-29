


import 'package:flutter/cupertino.dart';

import 'localization/language/lang_english.dart';
import 'localization/language/lang_tamil.dart';
import 'localization/language_model.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'hi'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ta':
        return LanguageTa();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
