import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';

class PageClients extends StatelessWidget {
  bool theme;
  PageClients({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme ? Colors.black :  Colors.green[700],
          title: Row(
            children: [
              const Text('Clientes'),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
        ),
        body: FutureBuilder(
          future: ApiManager.shared.request(
              baseUrl: "10.0.2.2:9595",
              pathUrl: "/cliente/buscar",
              type: HttpType.GET,
              modelType: ModelType.CLIENT),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.done:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final ClientList clientList =
                      snapshot.requireData as ClientList;
                  log('----> Datos :  Email = ${clientList.clientes.first.email} ,  Password = ${clientList.clientes.first.password}');
                  print('Trae los datos ');

                  return PageView.builder(
                    itemCount: clientList.clientes.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListView(
                          shrinkWrap: true,
                          children: [
                            Column(
                            children: [
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Cliente Id', value: clientList.clientes[index].dniCl.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Nombre', value: clientList.clientes[index].nombreCl),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Password', value: clientList.clientes[index].password),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Email', value: clientList.clientes[index].email),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Apellido 1', value: clientList.clientes[index].apellido1),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Apellido 2', value: clientList.clientes[index].apellido2),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Clase Via', value: clientList.clientes[index].claseVia),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Nombre Via', value: clientList.clientes[index].nombreVia),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Via', value: clientList.clientes[index].numeroVia.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Codigo Postal', value: clientList.clientes[index].codPostal.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Ciudad ', value: clientList.clientes[index].ciudad),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Telefono', value: clientList.clientes[index].numeroVia.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Observaciones', value: clientList.clientes[index].observaciones),
                            ],
                          ),
                        
                      ],
                    );
                    }
                    );
                
                }else{
                  return Container();
                }
            }
          },
        ));
  }
}
