import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/insurance_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';


class FormInsurance extends StatefulWidget {
  //VoidCallback llamada;
  final int numPoliza;
  final String ramo;
  final String fechaInicio;
  final String fechaFinal;
  final String condParticulares;
  final String observaciones;
  final int dniCl;

  FormInsurance(
      {Key? key,
      required this.numPoliza,
      required this.ramo,
      required this.fechaInicio,
      required this.fechaFinal,
      required this.condParticulares,
      required this.observaciones,
      required this.dniCl,
      //required this.llamada
      })
      : super(key: key);

  @override
  State<FormInsurance> createState() => _FormInsuranceState();
}

class _FormInsuranceState extends State<FormInsurance> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    

    TextEditingController numPolizaCtrl =
        TextEditingController(text: widget.numPoliza.toString());
    TextEditingController ramoCtrl =
        TextEditingController(text: widget.ramo.toString());
    TextEditingController fechaInicioCtrl =
        TextEditingController(text: widget.fechaInicio.toString());
    TextEditingController fechaVenCtrl =
        TextEditingController(text: widget.fechaFinal.toString());
    TextEditingController condPartCtrl =
        TextEditingController(text: widget.condParticulares.toString());
    TextEditingController obsersavacionCtrl =
        TextEditingController(text: widget.observaciones.toString());
    TextEditingController dniClCtrl =
        TextEditingController(text: widget.dniCl.toString());
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title:  Text(localization.dictionary(LabelsText.seguroModificar)),
      content: Form(
        key: _formKey,
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                enabled: false,
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.seguroNoPoliza))),
                controller: numPolizaCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese el numero  de la poliza'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.seguroRamo)),
                ),
                controller: ramoCtrl,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese el ramo' : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(),
                    label: Text(localization.dictionary(LabelsText.seguroDateInit))),
                controller: fechaInicioCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese la fecha de inicio'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.seguroDateFinish)),
                ),
                controller: fechaVenCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su fecha de vencimiento'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: Text(localization.dictionary(LabelsText.seguroConditions)),
                ),
                controller: condPartCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese condiciones'
                    : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(),
                    label: Text(localization.dictionary(LabelsText.seguroObserv))),
                controller: obsersavacionCtrl,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese observa' : null,
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(),
                    label: Text(localization.dictionary(LabelsText.seguroClientDni))),
                controller: dniClCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su dniProp'
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
                InsuranceProvider.shared.updateRowDb({
                  "ramo": ramoCtrl.text,
                  "fechaInicio": fechaInicioCtrl.text,
                  "fechaVencimiento": fechaVenCtrl.text,
                  "condicionesParticulares": condPartCtrl.text,
                  "observaciones": obsersavacionCtrl.text,
                  "dniCl": int.parse(dniClCtrl.text)
                }, int.parse(numPolizaCtrl.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(localization.dictionary(LabelsText.seguroActualizado))));
              
                Navigator.pop(context);

              } else {
                print('No se pudo actualizar su informacion');
              }
            },
            child:  Text(localization.dictionary(LabelsText.seguroActualizar)))
      ],
    );
  }
}
