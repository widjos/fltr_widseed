import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String tittle;
  bool theme;
  PageTwo({required this.tittle, required this.theme, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme ?  Colors.black : Colors.green[700]  ,
        title: Text(tittle),
      ),
      body: Column(
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
      ),
    );
  }
}
