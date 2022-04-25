import 'package:flutter/material.dart';
import 'package:test/model/sinister/sinister_list.dart';

class ShowSinister extends StatelessWidget {
  
  Sinister siniestro;
  
  ShowSinister({ Key? key , required this.siniestro }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  const Text('Informacion'),
      content: Form(
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Fecha")
                    ),
                 enabled: false,   
                 initialValue: siniestro.fechaSiniestro, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Numero Poliza")
                    ),
                 enabled: false,   
                 initialValue: siniestro.numeroPoliza.toString(), 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("Indenmizacion")
                    ),
                 enabled: false,   
                 initialValue: siniestro.indenmizacion, 
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), label: Text("causas")
                    ),
                 enabled: false,   
                 initialValue: siniestro.causas, 
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}