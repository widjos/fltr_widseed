import 'package:flutter/material.dart';
import 'package:test/provider/sinister_provider.dart';

class FormDeleteSinister extends StatefulWidget {
  int idSiniestro;
  //bool _idValidate = false;

  FormDeleteSinister({Key? key, required this.idSiniestro}) : super(key: key);

  @override
  State<FormDeleteSinister> createState() => _FormDeleteSinisterState();
}

class _FormDeleteSinisterState extends State<FormDeleteSinister> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Desea eliminar siniestro'),
      actions: [
        TextButton(
            onPressed: () {
              SinisterProvider.shared.deleteSinister(widget.idSiniestro);
              Navigator.pop(context);
            },
            child: const Text('Eliminar')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'))
      ],
    );
  }
}
