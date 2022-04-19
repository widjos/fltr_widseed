import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/pages/clients/page_clients.dart';
import 'package:test/pages/insurance/page_insurance.dart';
import 'package:test/pages/page_two/card_button.dart';
import 'package:test/pages/sinister/page_sinister.dart';

class PageTwo extends StatelessWidget {
  final String tittle;
  bool theme;
  PageTwo({required this.tittle, required this.theme, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

    return BlocProvider(
      create: (BuildContext context) => BasicBloc(),
      child: BlocListener<BasicBloc, BasicState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ClientsPage:
              final estado = state as ClientsPage;
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) =>  PageClients(theme: theme)));
              break;
            case SinisterPage:
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const Sinister()));
              break;

            case InsurancePage:
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const PageInsurance()));
              break;
          }
        },
        child: BlocBuilder<BasicBloc, BasicState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: theme ?  Colors.black : Colors.green[700] ,
                  title: const Text('Bienvenido'),
                ),
                body: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    LimitedBox(
                      maxHeight: 100,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Center(
                          child: Container(
                            child: Row(
                              children: [
                                const Icon(Icons.account_box_rounded, size: 40),
                                Text(
                                  tittle,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CardButton(
                        textDescription: 'Seguro',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context)
                              .add(ToInsurance());
                        },
                        picture: 'assets/img/seguro.jpg'),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 5,
                      indent: 60,
                      endIndent: 60,
                    ),
                    CardButton(
                        textDescription: 'Cliente',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToClients());
                        },
                        picture: 'assets/img/cliente.jpg'),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 5,
                      indent: 60,
                      endIndent: 60,
                    ),
                    CardButton(
                        textDescription: 'Siniestro',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToSinister());
                        },
                        picture: 'assets/img/siniestro.jpg')
                  ],
                ));
          },
        ),
      ),
    );
  }
}
/*
Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: const Text(
              'Bienvenido',
              style:  TextStyle(
                fontSize: 20
              ),
              ),
          ),
          ElevatedButton(
              onPressed: () {
                crashlytics.setCustomKey('email crashed', tittle);
                FirebaseCrashlytics.instance.crash();
              },
              child: const Text('Generar Error'))
        ],
      ),*/