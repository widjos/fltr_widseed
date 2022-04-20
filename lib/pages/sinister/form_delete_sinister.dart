import 'package:flutter/material.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';

class FormDeleteSinister extends StatefulWidget {

  final int idSiniestro;
  

  FormDeleteSinister({ Key? key, required this.idSiniestro  }) : super(key: key);

  @override
  State<FormDeleteSinister> createState() => _FormDeleteSinisterState();
}

class _FormDeleteSinisterState extends State<FormDeleteSinister> {
  
  @override
  Widget build(BuildContext context) {
    TextEditingController idSiniestroController = TextEditingController(text: widget.idSiniestro.toString());
    return AlertDialog(
      title: const Text('Desea eliminar siniestro'),
      content: Container(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextFormField(
            decoration: const InputDecoration(
              border:  UnderlineInputBorder(), 
              label:  Text("Id Siniestro")
            ),
            controller: idSiniestroController
          )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            ApiManager.shared.request(
              baseUrl: "10.0.2.2:9595",
              pathUrl: "/siniestro/eliminar",
              uriParams: {'idSiniestro': idSiniestroController.text},
              type: HttpType.DELETE,
              modelType: ModelType.SINISTER
              );

          }, child: const Text('Eliminar')
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('Cancelar')
          )
      ],
      
    );
  }
}