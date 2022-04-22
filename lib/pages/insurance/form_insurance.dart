import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';

class FormInsurance extends StatefulWidget {
   VoidCallback llamada;
   final int numPoliza;
   final String ramo;
   final String fechaInicio;
   final String fechaFinal;
   final String condParticulares;
   final String observaciones;
   final int dniCl;
   
   

   FormInsurance({ Key? key,
      required this.numPoliza,
      required this.ramo,
      required this.fechaInicio,
      required this.fechaFinal,
      required this.condParticulares,
      required this.observaciones,
      required this.dniCl,
      required this.llamada
    }) : super(key: key);

  @override
  State<FormInsurance> createState() => _FormInsuranceState();
}

class _FormInsuranceState extends State<FormInsurance> {

  
  @override
  Widget build(BuildContext context) {

    TextEditingController numPolizaCtrl = TextEditingController(text: widget.numPoliza.toString());
    TextEditingController ramoCtrl = TextEditingController(text: widget.ramo.toString());
    TextEditingController fechaInicioCtrl = TextEditingController(text: widget.fechaInicio.toString());
    TextEditingController fechaVenCtrl = TextEditingController(text: widget.fechaFinal.toString());
    TextEditingController condPartCtrl = TextEditingController(text: widget.condParticulares.toString());
    TextEditingController obsersavacionCtrl = TextEditingController(text: widget.observaciones.toString());
    TextEditingController dniClCtrl = TextEditingController(text: widget.dniCl.toString());
    final _formKey = GlobalKey<FormState>();
      return AlertDialog(
        title: const Text('Modificar Seguro'),
        content: Form(
          key: _formKey,
          child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Nombre")),
                controller: numPolizaCtrl,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese el numero  de la poliza' : null,
                    
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Ramo"),
                ),
                controller: ramoCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese el ramo'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Fecha inicio")),
                controller: fechaInicioCtrl,
                validator: (value) =>
                    value == null || value.isEmpty ? 'ingrese la fecha de inicio' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("fecha Vencimiento"),
                ),
                controller: fechaVenCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese su fecha de vencimiento'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Condiciones"),
                ),
                controller: condPartCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese condiciones'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("observaciones")),
                controller: obsersavacionCtrl,
                validator: (value) => value == null || value.isEmpty
                    ? 'ingrese observa'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("dniPropietario")),
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
            onPressed: (){

              if(_formKey.currentState!.validate()){
                ApiManager.shared.request(
                    baseUrl: "10.0.2.2:9595",
                    pathUrl: "/seguro/guardar",
                    bodyParams: json.encode({
                      "numeroPoliza": numPolizaCtrl.text,
                      "ramo": ramoCtrl.text,
                      "fechaInicio": fechaInicioCtrl.text,
                      "fechaVencimiento": fechaVenCtrl.text,
                      "condicionesParticulares": condPartCtrl.text,
                      "observaciones": obsersavacionCtrl.text,
                      "dniCl": dniClCtrl.text
                    }),
                    type: HttpType.POST);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Actualizado')));

                        
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vlidar form primer')));
              
              }

            } ,
            child: const Text("Actualizar")),
             TextButton(
            onPressed: widget.llamada,
            child: const Text('Salir'))
        ],
      );
      
      
    
  }
}