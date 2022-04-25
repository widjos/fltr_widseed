import 'package:flutter/material.dart';
import 'package:test/model/insurance/insurance_list.dart';

class ShowInsurance extends StatelessWidget {
  
  Insurance seguro;

  ShowInsurance({ Key? key, required this.seguro }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informacio'),
      content: Form(
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Fecha Inicio")
                    ),
                 enabled: false,   
                 initialValue: seguro.fechaInicio, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Fecha Final")
                    ),
                 enabled: false,   
                 initialValue: seguro.fechaVencimiento, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Ramo")
                    ),
                 enabled: false,   
                 initialValue: seguro.ramo, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Cliente Dni")
                    ),
                 enabled: false,   
                 initialValue: seguro.dniCl.toString(), 
              ),
          ]),
        ),
      ),
      
    );
  }
}