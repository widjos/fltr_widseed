import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';

class FormClient extends StatefulWidget {
  
  TextEditingController nombreController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController apellido1Controller = TextEditingController();
  TextEditingController apellido2Controller = TextEditingController();
  TextEditingController claseViaController = TextEditingController();
  TextEditingController nombreViaController = TextEditingController();
  TextEditingController numeroViaController = TextEditingController();
  TextEditingController condPostalController = TextEditingController();
  TextEditingController ciudadController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController observController = TextEditingController();

  FormClient({ Key? key }) : super(key: key);

  @override
  State<FormClient> createState() => _FormClientState();
}

class _FormClientState extends State<FormClient> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const  Text('Nuevo Cliente'),
      content: Container(
        height: 400,
        width: 400,
        child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("Nombre")
            ),
            controller: widget.nombreController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("password")
            ),
            controller: widget.passController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("email")
            ),
            controller: widget.emailController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("apellido1")
            ),
            controller: widget.apellido1Controller
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("apellido2")
            ),
            controller: widget.apellido2Controller
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("clase Via")
            ),
            controller: widget.claseViaController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("nombre Via")
            ),
            controller: widget.nombreViaController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("numero VIa")
            ),
            controller: widget.numeroViaController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("Cod Postal")
            ),
            controller: widget.condPostalController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("Ciudad")
            ),
            controller: widget.ciudadController
          ), 
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("telefono")
            ),
            controller: widget.telefonoController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("obsr")
            ),
            controller: widget.observController
          ),
        ],
      ),
      ),
      actions: [
        TextButton(onPressed: (){
          print("httpRequest");
          var map = jsonEncode({
                    "nombreCl": widget.nombreController.text,
                    "password": widget.passController.text,
                    "email" : widget.emailController.text,
                    "apellido1": widget.apellido1Controller.text,
                    "apellido2": widget.apellido2Controller.text,
                    "claseVia": widget.claseViaController.text,
                    "nombreVia": widget.nombreViaController.text,
                    "numeroVia": widget.numeroViaController.text,
                    "codPostal": widget.condPostalController.text,
                    "ciudad": widget.ciudadController.text,
                    "telefono": widget.telefonoController.text,
                    "observaciones": widget.observController.text
              });

            log(map.toString());
          ApiManager.shared.request(
              baseUrl: "10.0.2.2:9595",
              pathUrl: "/cliente/guardar",
              bodyParams: json.encode({
                    "nombreCl": widget.nombreController.text,
                    "password": widget.passController.text,
                    "email" : widget.emailController.text,
                    "apellido1": widget.apellido1Controller.text,
                    "apellido2": widget.apellido2Controller.text,
                    "claseVia": widget.claseViaController.text,
                    "nombreVia": widget.nombreViaController.text,
                    "numeroVia": widget.numeroViaController.text,
                    "codPostal": widget.condPostalController.text,
                    "ciudad": widget.ciudadController.text,
                    "telefono": widget.telefonoController.text,
                    "observaciones": widget.observController.text
              })
              
              ,
              type: HttpType.POST,
              modelType: ModelType.CLIENT);
        }, child: const Text("Registrar")),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('Cancelar')
          )
      ],
      
    );
  }
}