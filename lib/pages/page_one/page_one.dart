import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/pages/page_two/page_two.dart';
import 'package:test/widgets/gradient_back.dart';
import 'package:test/widgets/text_input.dart';
import 'package:test/widgets/button_green.dart';

class PageOne extends StatelessWidget {
  final String _nombreUser = 'wid';
  final String _passUser = '12345';
  final _textControllerUserName = TextEditingController();
  final _textControllerPassword = TextEditingController();

  PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 204, 5),
          title: const Text('Tarea 1'),
        ),
        body: BlocProvider(
            create: (BuildContext context) => BasicBloc(),
            child: BlocListener<BasicBloc, BasicState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case AppStarted:
                    break;
                  case PageChanged:
                    final estado = state as PageChanged;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => PageTwo(tittle: estado.title)));
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
                                    isPassword: false),
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
                                    if (_nombreUser ==
                                            _textControllerUserName.text &&
                                        _passUser ==
                                            _textControllerPassword.text) {
                                      log("Log in ");
                                      BlocProvider.of<BasicBloc>(context)
                                          .add(ButtonPressed());
                                    } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("usuario o password incorrecto")));
                                    }
                                  }, 300.0, 50.0))
                            ],
                          ))
                    ],
                  );
                },
              ),
            )));
  }
}
