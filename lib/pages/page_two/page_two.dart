import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String tittle;
  bool theme;
  PageTwo({required this.tittle, required this.theme, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme ?  Colors.green[700] : Colors.black ,
          title: Text(tittle),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            LimitedBox(
              maxHeight: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/img/seguro.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(166, 66, 74, 65),
                      
                      ),
                      child: const Center(
                        child: Text(
                          'Seguros',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 5,
            ),
            LimitedBox(
              maxHeight: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/img/cliente.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(166, 66, 74, 65),
                      ),
                      child: const Center(
                        child: Text(
                          'Clientes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 5,
            ),
            LimitedBox(
              maxHeight: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/img/siniestro.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(166, 66, 74, 65),
                      ),
                      child: const Center(
                        child: Text(
                          'Siniestro',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
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