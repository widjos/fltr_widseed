import 'package:flutter/material.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';

class Clients extends StatelessWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Container(
        child: const Text('Hola'),
      ),
    );
  }
}
