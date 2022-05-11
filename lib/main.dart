import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/page_one/page_one.dart';
import 'package:test/pages/page_settings/page_settings.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/prefs/style.dart';
import 'package:test/prefs/theme_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/prefs/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
      () => runApp(const MyApp()),
      ((error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack)));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();
  ThemeProvider themeChangeProvider = ThemeProvider();
  LanguageProvider langProvider = LanguageProvider();
  

  void getCurrentTheme() async {
    DatabaseReference refInit =
        FirebaseDatabase.instance.ref('preferences/theme');
    refInit.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      themeProvider.darkTheme = data as bool;
      switchValue = themeProvider.darkTheme;
    });
    //themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  late Future<void> _firebase;

  Future<void> _initializeFB() async {
    await Firebase.initializeApp();
    await _initializeC();
    await _initializeRC();
    await _initializeCM();
    getCurrentTheme();
    await getCurrentLanguaje();
    
    //await _deleteDb();
    //await SinisterProvider.shared.initSinistroTable();
    //await ClientProvider.shared.initClientDb();
    //await InsuranceProvider.shared.initInsuranceDb();
  }


  Future<void> _initializeC() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    Function onOriginalError = FlutterError.onError as Function;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      onOriginalError(errorDetails);
    };
  }

  Future<void> _initializeRC() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.setDefaults({'parametro': 5});
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero));
    await remoteConfig.fetchAndActivate();
    print('------------------------> ' + remoteConfig.getString('parametro'));
  }

  Future<void> _initializeCM() async {
    FirebaseMessaging cloudMessaging = FirebaseMessaging.instance;

    String? token = await cloudMessaging.getToken();
    print('token: $token');
    FirebaseMessaging.onMessage.listen((event) {
      print('Titulo -- ' + event.notification!.title.toString());
      print('Mensaje -- ' + event.notification!.body.toString());
    });
  }

  
  Future<void> getCurrentLanguaje() async {
    langProvider.setLaguaje = await langProvider.getDefaultLanguage();
  }

  @override
  void initState() {
    super.initState();
    _firebase = _initializeFB();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: ((context,snapshot){
          if(snapshot.connectionState ==ConnectionState.done){
            return  MultiProvider(
      providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(create: (_) => LanguageProvider())
        ],
        child: Consumer2(
          builder: (context, ThemeProvider themeProvider, LanguageProvider _languajeProvider, widget){
            return MaterialApp(
              locale: _languajeProvider.getLang,
              localizationsDelegates:  const[
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const[
                Locale('es',''),
                Locale('en',''),
              ],
              theme: Style.themeData(themeProvider.darkTheme),
              debugShowCheckedModeBanner: false,
              title: 'MySeedFlutter',
              home: PageOne(theme: switchValue)
            );
          }
          ),
      );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })
      );
  }
}

/**             Scaffold(
                        appBar: AppBar(
                          backgroundColor: themeProvider.darkTheme
                              ? Colors.black
                              : Colors.green[700],
                          title: Row(
                            children: [
                               const Text('Bienvenido'),
                              const Spacer(),
                               IconButton(
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PageSettings()));
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            )) 
                            ],
                          ),
                        ),
                        body: Stack(
                          children: [
                            PageOne(theme: switchValue),
                            Container(
                                child: Switch(
                                    value: switchValue,
                                    onChanged: (val) async {
                                      DatabaseReference ref = FirebaseDatabase
                                          .instance
                                          .ref('preferences');

                                      themeProvider.darkTheme =
                                          !themeProvider.darkTheme;
                                      await ref.update(
                                          {'theme': themeProvider.darkTheme});
                                      setState(() {
                                        switchValue = val;
                                      });
                                    })),
                          ],
                        )), */