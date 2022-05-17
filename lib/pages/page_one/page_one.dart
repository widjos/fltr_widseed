import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/pages/page_settings/page_settings.dart';
import 'package:test/pages/page_two/page_two.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/client_provider.dart';
import 'package:test/provider/insurance_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/provider/sinister_provider.dart';
import 'package:test/repository/sinister_repository.dart';
import 'package:test/util/app_strings.dart';
import 'package:test/util/encriptor.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/gradient_back.dart';
import 'package:test/widgets/text_input.dart' as myInput;
import 'package:test/widgets/button_green.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:local_auth/local_auth.dart';

// ignore: must_be_immutable
class PageOne extends StatefulWidget {
  bool theme;
  late bool connected;

  PageOne({Key? key, required this.theme}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final _textControllerUserName = TextEditingController();
  final _textControllerPassword = TextEditingController();
  final _auth = LocalAuthentication();
  bool rememberMe = false;
  String _mensaje = "No autorizado";
  late SharedPreferences prefs;


  @override
  void initState() {
    _initPrefs();
    super.initState();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    _textControllerUserName.text = prefs.getString('email') ?? '';
    rememberMe = prefs.getBool('remember') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

    return BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AppStarted:
                break;
              case LoginDone:
                final estado = state as LoginDone;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => PageTwo(
                            tittle: estado.email, theme: widget.theme)));
                break;

              case WrongCredentials:
                final estado = state as WrongCredentials;
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text(localization.dictionary(LabelsText.loginErrorEmailOrPass))));
                break;

              case EmailNotValid:
                final estado = state as EmailNotValid;
                ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(localization.dictionary(LabelsText.loginErrorEmailInvalid))));
                break;

              case AuthLocalError:
                final authError = state as AuthLocalError;
                showUpDialog(context, authError.mensaje, localization.dictionary(LabelsText.loginErrorAuth));
                break;
            }
          },
          child: BlocBuilder<BasicBloc, BasicState>(
            builder: (context, state) {
              if (state is AppStarted) {
                print('Aplication started');
              }

              return Scaffold(
                  body: OfflineBuilder(
                connectivityBuilder: ((BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  widget.connected = connectivity != ConnectivityResult.none;
                  checkDataConfiguration(widget.connected);
                  return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Theme.of(context).primaryColor,
                          title: Row(
                            children: [
                               Text(localization.dictionary(LabelsText.homePageTittle)),
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
                        body:  Stack(
                    children: [
                      GradientBack(tittle: 'Log In'),
                      Container(
                          margin:
                              const EdgeInsets.only(top: 120.0, bottom: 20.0),
                          child: ListView(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20),
                                child:  Text(
                                  localization.dictionary(LabelsText.clientEmail) 
                                  ,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: myInput.TextInput(
                                    hintText: 'Nombre de Usuario',
                                    inputType: null,
                                    controller: _textControllerUserName,
                                    isPassword: false),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: myInput.TextInput(
                                  hintText: localization.dictionary(LabelsText.clientPass),
                                  inputType: null,
                                  controller: _textControllerPassword,
                                  isPassword: true,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: rememberMe,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            rememberMe = value!;
                                          });
                                        },
                                      ),
                                       Text(
                                        localization.dictionary(LabelsText.loginRememberMe)
                                        ,
                                        style:  Theme.of(context).textTheme.bodyText1,
                                      ),
                                      Container(
                                        child: ButtonGreen(localization.dictionary(LabelsText.loginForget), () async {
                                          var prefs = await SharedPreferences
                                              .getInstance();
                                          if (prefs.containsKey('email') &&
                                              prefs.containsKey('pass')) {
                                            prefs.remove('email');
                                            prefs.remove('pass');
                                            _textControllerUserName.text = '';
                                            _textControllerPassword.text = '';
                                            prefs.setBool('remember', false);

                                            print("olvido sus credenciales");
                                          }
                                        }, 80, 40),
                                      )
                                    ],
                                  )),
                              widget.connected
                                  ? Container(
                                      width: 70,
                                      child: ButtonGreen(localization.dictionary(LabelsText.loginButtonOnline),
                                          () async {
                                        final isAuth = await authenticate();
                                        if (isAuth) {
                                           var prefs = await SharedPreferences
                                            .getInstance();
                                        if (prefs.getString('email') != null &&
                                            prefs.getString('pass') != null) {
                                          setState(() {
                                            _textControllerUserName.text =
                                                prefs.getString('email') ?? '';
                                          });

                                          final isAutho = await authenticate();
                                          if (isAutho) {
                                            final passB64 =
                                                prefs.getString('pass') ?? '';

                                               final valueStr = await Encriptor.shared.desencriptar(passB64);
                                               _textControllerPassword.text = valueStr;
                                            BlocProvider.of<BasicBloc>(context)
                                                .add(LoginSpring(
                                                    email:
                                                        _textControllerUserName
                                                            .text,
                                                    pass:
                                                        _textControllerPassword
                                                            .text));
                                          }
                                        } else if (_textControllerUserName.text.isNotEmpty &&
                                            _textControllerPassword.text.isNotEmpty) {
                                          if (emailValid(
                                              _textControllerUserName.text)) {
                                            if (rememberMe) {
                                              final pass = _textControllerPassword.text;
                                              prefs.setString('email', _textControllerUserName.text);
                                              prefs.setString('pass',await Encriptor.shared.encriptar(pass)); 
                                              prefs.setBool('remember', rememberMe);
                                              
                                              BlocProvider.of<BasicBloc>(context)
                                                  .add(LoginSpring(
                                                      email:_textControllerUserName.text,
                                                      pass:
                                                          _textControllerPassword
                                                              .text));
                                            }
                                          } else {
                                            BlocProvider.of<BasicBloc>(context)
                                                .add(EmailInvalid());
                                          }
                                        }
                                        } else {
                                       
                                          BlocProvider.of<BasicBloc>(context)
                                              .add(ShowMensaje(
                                                  mensaje: _mensaje));
                                        }
                                     
                                      }, 300.0, 50.0))
                                  : Container(
                                      width: 70,
                                      child:
                                          ButtonGreen(localization.dictionary(LabelsText.loginButtonOffline), () {
                                        if (_textControllerUserName
                                                .text.isNotEmpty &&
                                            _textControllerPassword
                                                .text.isNotEmpty) {
                                          if (emailValid(
                                              _textControllerUserName.text)) {
                                            BlocProvider.of<BasicBloc>(context)
                                                .add(LoginDb(
                                                    email:
                                                        _textControllerUserName
                                                            .text,
                                                    pass:
                                                        _textControllerPassword
                                                            .text));
                                          } else {
                                            BlocProvider.of<BasicBloc>(context)
                                                .add(EmailInvalid());
                                          }
                                        }
                                      }, 300.0, 50.0)),
                              Container(
                                padding: EdgeInsets.all(12),
                                child: Row(children: [
                                  widget.connected
                                      ? ButtonIcon(true, Icons.wifi, 20,
                                          Theme.of(context).primaryColor, () {})
                                      : ButtonIcon(
                                          true,
                                          Icons.wifi_off,
                                          20,
                                          Theme.of(context).primaryColor,
                                          () {}),
                                ]),
                              )
                            ],
                          )),
                    ],
                  )
                        );
                }),
                child: Container(),
              ));
            },
          ),
        )); //);
  }

  bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void checkDataConfiguration(bool connected) async {
    if (connected) {
      await SinisterProvider.shared.DeleteTable();
      await ClientProvider.shared.DeleteTable();
      await InsuranceProvider.shared.DeleteTable();
      await SinisterProvider.shared.initSinistroTable();
      await ClientProvider.shared.initClientDb();
      await InsuranceProvider.shared.initInsuranceDb();
    } else {
      print(await SinisterRepository.shared.showTable(table: 'siniestro'));
    }
  }

  Future<void> _deleteDb() async {
    Directory directoryDb = await getApplicationDocumentsDirectory();
    String path = "${directoryDb.path}test_db";
    databaseFactory.deleteDatabase(path);
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Future<bool> authenticate() async {
    final isAvalible = await hasBiometrics();
    if (!isAvalible) return false;
    try {
      return await _auth.authenticate(
        localizedReason: 'Escaner de la huella dactilar',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
    } on PlatformException catch (e) {
      setState(() {
        switch (e.code) {
          case 'NotAvailable':
            _mensaje = 'No tiene registrado ningun metodo biometrico';
            break;
          case 'PasscodeNotSet':
            _mensaje = 'Aun no configura un passcode en (iOS) o PIN/pattern/password (Android) en el dispositivo.';
            break;
          case 'NotEnrolled':
            _mensaje = 'No tiene almacenada ninguna huella dactilar';
            break;
          case 'LockedOut ':
            _mensaje = 'A agotado sus 5 intentos ahora tiene que esperar almenos 30 segundos para volver a intentar';
            break;
          case 'OtherOperatingSystem ':
            _mensaje = 'Su sitema operativo no es soportado';
            break;
          case 'PermanentlyLockedOut':
            _mensaje = 'El sensor se ha bloqueado por muchos intentos fallidos se requiere una verificacion mas estricta con PIN/Pattern/Password';
            break;
            
        }
      });

      print(e.message);

      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  void showUpDialog(BuildContext context, String mensaje, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text(title),
            content: Expanded(
              child: Text(mensaje),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}

