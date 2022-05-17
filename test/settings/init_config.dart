
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/prefs/theme_provider.dart';
import 'package:test/provider/language_provider.dart';

class InitConfig {

  ThemeProvider themeProvider = ThemeProvider(); 
  LanguageProvider langProvider = LanguageProvider();
  
  InitConfig._privateContructor();

  static final InitConfig shared = InitConfig._privateContructor();

  Future<void> loadConfiguration() async {
     langProvider.setLaguaje = Locale('es','ES');
     await Firebase.initializeApp();
    // await _initializeC();
  }

   Future<void> _initializeC() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Function onOriginalError = FlutterError.onError as Function;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      onOriginalError(errorDetails);
    };
  }

}