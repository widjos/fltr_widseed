import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';

class FormClient extends StatefulWidget {
  VoidCallback llamada;
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

  FormClient({Key? key, required this.llamada}) : super(key: key);

  @override
  State<FormClient> createState() => _FormClientState();
}

class _FormClientState extends State<FormClient> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Nuevo Cliente'),
      content: Form(
        key: _formKey,
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Nombre")),
                controller: widget.nombreController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su nombre' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("password"),
                ),
                controller: widget.passController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su password'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("email")),
                controller: widget.emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("apellido1"),
                ),
                controller: widget.apellido1Controller,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su apellido1'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("apellido2"),
                ),
                controller: widget.apellido2Controller,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su apellido1'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("clase Via")),
                controller: widget.claseViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su clasevia'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("nombre Via")),
                controller: widget.nombreViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su nombrevia'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("numero VIa"),
                ),
                controller: widget.numeroViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su numerovia'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Cod Postal"),
                ),
                controller: widget.condPostalController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su codPostal'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Ciudad")),
                controller: widget.ciudadController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su ciudad' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("telefono"),
                ),
                controller: widget.telefonoController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su telefono'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("obsr"),
                ),
                controller: widget.observController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su observa'
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                ApiManager.shared.request(
                    baseUrl: "10.0.2.2:9595",
                    pathUrl: "/cliente/guardar",
                    bodyParams: json.encode({
                      "nombreCl": widget.nombreController.text,
                      "password": widget.passController.text,
                      "email": widget.emailController.text,
                      "apellido1": widget.apellido1Controller.text,
                      "apellido2": widget.apellido2Controller.text,
                      "claseVia": widget.claseViaController.text,
                      "nombreVia": widget.nombreViaController.text,
                      "numeroVia": widget.numeroViaController.text,
                      "codPostal": widget.condPostalController.text,
                      "ciudad": widget.ciudadController.text,
                      "telefono": widget.telefonoController.text,
                      "observaciones": widget.observController.text
                    }),
                    type: HttpType.POST,
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nuevo usuario registrado')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vlidar form primer')));
              }
            },
            child: const Text("Registrar")),
        TextButton(onPressed: widget.llamada, child: const Text('Salir'))
      ],
    );
  }
}
