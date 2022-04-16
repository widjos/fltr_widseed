
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/pages/clients/clients.dart';
import 'package:test/pages/page_two/page_two.dart';
import 'package:test/prefs/theme_provider.dart';
import 'package:test/widgets/gradient_back.dart';
import 'package:test/widgets/text_input.dart';
import 'package:test/widgets/button_green.dart';

// ignore: must_be_immutable
class PageOne extends StatelessWidget {
  final _textControllerUserName = TextEditingController();
  final _textControllerPassword = TextEditingController();
  bool theme;

  PageOne({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

    return /*Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 204, 5),
          title: const Text('Tarea 1'),
        ),
        body: */BlocProvider(
            create: (BuildContext context) => BasicBloc(),
            child: BlocListener<BasicBloc, BasicState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case AppStarted:
                    break;
                  case LoginDone:
                    final estado = state as LoginDone;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => PageTwo(tittle:estado.email, theme: theme)));
                    break;

                  case WrongCredentials:
                    final estado = state as WrongCredentials;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("usuario o password incorrecto")));
                    break;

                  case EmailNotValid:
                    final estado = state as EmailNotValid;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ingrese un correo valido")));
                    break;

                    

                }
              },
              child: BlocBuilder<BasicBloc, BasicState>(
                builder: (context, state) {
                  if (state is AppStarted) {
                    print('Aplication started');
                  }

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
                                child: TextInput(
                                    hintText: 'Nombre de Usuario',
                                    inputType: null,
                                    controller: _textControllerUserName,
                                    isPassword: false
                                    ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: TextInput(
                                  hintText: 'Password',
                                  inputType: null,
                                  controller: _textControllerPassword,
                                  isPassword: true,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                  width: 70,
                                  child: ButtonGreen('Ingresar', () {

                                      if(_textControllerUserName.text.isNotEmpty && _textControllerPassword.text.isNotEmpty){
                                        
                                        if(emailValid(_textControllerUserName.text)){
                                          BlocProvider.of<BasicBloc>(context)
                                          .add(LoginBegin(email: _textControllerUserName.text, pass: _textControllerPassword.text));
                                   
                                        }else{
                                           BlocProvider.of<BasicBloc>(context)
                                          .add(EmailInvalid());
                                        }
                                        
                                      }
                                      
                                  }, 300.0, 50.0)),
                              
                            ],
                          ))
                    ],
                  );
                },
              ),
            ));//);
  }

  bool emailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
