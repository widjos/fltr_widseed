
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:test/util/app_string_en.dart';
import 'package:test/util/app_string_es.dart';
import 'package:test/util/app_strings.dart';

class AppLocalizations {
  final Locale locale;  

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String,Map<LabelsText,String>> _localizeValues = {
    'en': dictionary_en,
    'es': dictionary_es
  };

  String dictionary(LabelsText label) => _localizeValues[locale.languageCode]![label] ?? "";

}


class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{

  const  AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['es', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

  
}