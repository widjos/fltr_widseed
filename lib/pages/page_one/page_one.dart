import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as myEncript;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/pages/page_two/page_two.dart';
import 'package:test/provider/client_provider.dart';
import 'package:test/provider/insurance_provider.dart';
import 'package:test/provider/sinister_provider.dart';
import 'package:test/repository/master_repository.dart';
import 'package:test/repository/sinister_repository.dart';
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
  static final _auth = LocalAuthentication();
  bool rememberMe = false;
  late SharedPreferences prefs;
  final key = myEncript.Key.fromBase64('my32lengthsupersecretnooneknows1');

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
    FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
    final key = myEncript.Key.fromUtf8('my 32 length key................');
    final iv = myEncript.IV.fromLength(16);

    final encrypter = myEncript.Encrypter(myEncript.AES(key, padding: null));

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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("usuario o password incorrecto")));
                break;

              case EmailNotValid:
                final estado = state as EmailNotValid;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Ingrese un correo valido")));
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
                  return Stack(
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
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
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
                                  hintText: 'Password',
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
                                      const Text(
                                        'Recordar mis credenciales',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: "Lato",
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ButtonGreen('Olvidar', () async {
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
                                      }, 80, 40)
                                    ],
                                  )),
                              widget.connected
                                  ? Container(
                                      width: 70,
                                      child: ButtonGreen('Ingresar Online',
                                          () async {
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
                                                final bytesPass =   (encrypter.decryptBytes(
                                                  myEncript.Encrypted.fromBase64(passB64) ,iv: iv));
                                          

                                            final valueStr = utf8.decode(bytesPass);
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
                                        } else if (_textControllerUserName
                                                .text.isNotEmpty &&
                                            _textControllerPassword
                                                .text.isNotEmpty) {
                                          if (emailValid(
                                              _textControllerUserName.text)) {
                                            /*  BlocProvider.of<BasicBloc>(context)
                                                .add(LoginSpring(
                                                    email:
                                                        _textControllerUserName
                                                            .text,
                                                    pass:
                                                        _textControllerPassword
                                                            .text)); */

                                            if (rememberMe) {
                                              final pass =
                                                  _textControllerPassword.text;
                                              prefs.setString('email',
                                                  _textControllerUserName.text);
                                              prefs.setString(
                                                  'pass',
                                               encrypter.encrypt(pass, iv: iv).base64); 
                                              prefs.setBool(
                                                  'remember', rememberMe);
                                              BlocProvider.of<BasicBloc>(
                                                      context)
                                                  .add(LoginSpring(
                                                      email:
                                                          _textControllerUserName
                                                              .text,
                                                      pass:
                                                          _textControllerPassword
                                                              .text));
                                            }
                                          } else {
                                            BlocProvider.of<BasicBloc>(context)
                                                .add(EmailInvalid());
                                          }
                                        }
                                      }, 300.0, 50.0))
                                  : Container(
                                      width: 70,
                                      child:
                                          ButtonGreen('Ingresar offLine', () {
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
                            ],
                          )),
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: widget.connected
                              ? ButtonIcon(true, Icons.wifi, 20,
                                  Theme.of(context).primaryColor, () {})
                              : ButtonIcon(true, Icons.wifi_off, 20,
                                  Theme.of(context).primaryColor, () {}))
                    ],
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
      print(e);
      return false;
    }
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }
}


/**                                        
                                         
                                         
                                         

*/
