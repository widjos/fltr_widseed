import 'package:flutter/material.dart';
import 'package:test/model/client/client_list.dart';

class ShowClient extends StatelessWidget {

  Client cliente;

  ShowClient({ Key? key , required this.cliente }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Información'),
      content: Form(
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Apellido1")
                    ),
                 enabled: false,   
                 initialValue: cliente.apellido1, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Apellido2")
                    ),
                 enabled: false,   
                 initialValue: cliente.apellido2, 

              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Ciudad")
                    ),
                 enabled: false,   
                 initialValue: cliente.ciudad, 

              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Clase Via")
                    ),
                 enabled: false,   
                 initialValue: cliente.claseVia, 

              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Nombre Via")
                    ),
                 enabled: false,   
                 initialValue: cliente.nombreVia, 

              ),
            ],
          ),
        ),
      ),
      
    );
  }
}