import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/pages/clients/form_cliente.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/row_data.dart';

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
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return FormClient();
                    });
                  },
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

                  return  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    itemCount: clientList.clientes.length,
                    itemBuilder: (BuildContext context, int index){
                      return 
                            Column(
                            children: [

                              RowData(idData1: 'Id:', valueData1: clientList.clientes[index].dniCl.toString(), idData2: 'email:', valueData2: clientList.clientes[index].email, myButton: 
                              ButtonIcon(true, Icons.mark_chat_unread_sharp, 20, Colors.green, (){

                               
                              }),)
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Cliente Id', value: clientList.clientes[index].dniCl.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Nombre', value: clientList.clientes[index].nombreCl),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Password', value: clientList.clientes[index].password),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Email', value: clientList.clientes[index].email),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Apellido 1', value: clientList.clientes[index].apellido1),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Apellido 2', value: clientList.clientes[index].apellido2),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Clase Via', value: clientList.clientes[index].claseVia),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Nombre Via', value: clientList.clientes[index].nombreVia),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Via', value: clientList.clientes[index].numeroVia.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Codigo Postal', value: clientList.clientes[index].codPostal.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Ciudad ', value: clientList.clientes[index].ciudad),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Telefono', value: clientList.clientes[index].numeroVia.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Observaciones', value: clientList.clientes[index].observaciones),
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
