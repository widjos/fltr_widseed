
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/util/app_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static Locale? _locale;

  Future<Locale> getDefaultLanguage() async {
    final String? savedLang = await AppPreferences.shared.getString(AppPreferences.LANGUAGE_APP);
    if(savedLang != null){
      return Locale(savedLang, '');
    }
    else{
      _locale = Locale(Platform.localeName.substring(0,2),'');
      return _locale!;
    }
  }

  Locale get getLang => _locale!;

  set setLaguaje(Locale lang){
    _locale = lang;
    AppPreferences.shared.setString(AppPreferences.LANGUAGE_APP, lang.languageCode);
    notifyListeners();
  }
}