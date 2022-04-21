import 'package:flutter/material.dart';
import 'package:test/model/client/client.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:http/http.dart' as http;
import 'package:test/widgets/alert_icon.dart';

class FormDeleteSinister extends StatefulWidget {
  final int idSiniestro;
  bool _idValidate = false;

  FormDeleteSinister({Key? key, required this.idSiniestro}) : super(key: key);

  @override
  State<FormDeleteSinister> createState() => _FormDeleteSinisterState();
}

class _FormDeleteSinisterState extends State<FormDeleteSinister> {
  @override
  Widget build(BuildContext context) {
    TextEditingController idSiniestroController =
        TextEditingController(text: widget.idSiniestro.toString());
    return AlertDialog(
      title: const Text('Desea eliminar siniestro'),
      content: Container(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  label: const Text("Id Siniestro"),
                  errorText: widget._idValidate ? "Falta el id" : null),
              controller: idSiniestroController,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                if (idSiniestroController.text.isEmpty) {
                  widget._idValidate = true;
                } else {
                  widget._idValidate = false;
                  ApiManager.shared
                      .request(
                          baseUrl: "10.0.2.2:9595",
                          pathUrl: "/siniestro/eliminar",
                          uriParams: {
                            'idSiniestro': idSiniestroController.text
                          },
                          type: HttpType.DELETE,
                          modelType: ModelType.SINISTER)
                      .then((value) {
                    value != null && value.response.statusCode == 200
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertIcon(
                                  title: 'Exito',
                                  alert: 'Se elimino el siniestro');
                            })
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertIcon(
                                  title: 'Error', alert: 'No se pudo eliminar');
                            });
                  });
                }
              });

              /*
            ApiManager.shared.request(
              baseUrl: "10.0.2.2:9595",
              pathUrl: "/siniestro/eliminar",
              uriParams: {'idSiniestro': idSiniestroController.text},
              type: HttpType.DELETE,
              modelType: ModelType.SINISTER
              );*/
            },
            child: const Text('Eliminar')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'))
      ],
    );
  }
}
