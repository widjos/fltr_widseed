import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/model/Client.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';

class PageClients extends StatelessWidget {
  const PageClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: FutureBuilder(
        future: ApiManager.shared.request(baseUrl: "10.0.2.2:9595", pathUrl: "/cliente/buscar", type: HttpType.GET),
        builder: (BuildContext context, snapshot){

          if(snapshot.hasData){
            final Client client = snapshot.requireData as Client;
             log('----> Datos :  Email = ${client.email} ,  Password = ${client.password}'); 
             log('Trae los datos '); 
          }  

          return Container();
        } ,
      )
    );
  }
}
