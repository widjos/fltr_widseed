
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/client_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';

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
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title:  Text(localization.dictionary(LabelsText.clientNew)),
      content: Form(
        key: _formKey,
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientName))),
                controller: widget.nombreController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su nombre' : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientPass)),
                ),
                controller: widget.passController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su password'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientEmail))),
                controller: widget.emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su email' : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientLastName1)),
                ),
                controller: widget.apellido1Controller,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su apellido1'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientLastName2)),
                ),
                controller: widget.apellido2Controller,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su apellido2'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientClassVia))),
                controller: widget.claseViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su clasevia'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientNameVia))),
                controller: widget.nombreViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su nombrevia'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border:  const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientNumberVia)),
                ),
                controller: widget.numeroViaController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su numerovia'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientCodPostal)),
                ),
                controller: widget.condPostalController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su codPostal'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientCity))),
                controller: widget.ciudadController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese su ciudad' : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientTel)),
                ),
                controller: widget.telefonoController,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su telefono'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.clientObservation)),
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

                  var  temp =  {
                      "nombreCl": widget.nombreController.text,
                      "password": widget.passController.text,
                      "email": widget.emailController.text,
                      "apellido1": widget.apellido1Controller.text,
                      "apellido2": widget.apellido2Controller.text,
                      "claseVia": widget.claseViaController.text,
                      "nombreVia": widget.nombreViaController.text,
                      "numeroVia": int.parse(widget.numeroViaController.text),
                      "codPostal": int.parse(widget.condPostalController.text),
                      "ciudad": widget.ciudadController.text,
                      "telefono": int.parse(widget.telefonoController.text),
                      "observaciones": widget.observController.text
                    };
                    final clientTemp = Client.toDb(temp);
                    ClientProvider.shared.saveClientDb([clientTemp]);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(localization.dictionary(LabelsText.formValidation))));
              }
            },
            child:  Text(localization.dictionary(LabelsText.formRegister))),
        TextButton(onPressed: widget.llamada, child:  Text(localization.dictionary(LabelsText.formBack)))
      ],
    );
  }
}
