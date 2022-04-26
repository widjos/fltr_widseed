import 'package:flutter/cupertino.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/repository/cliente_repository.dart';

import '../util/app_type.dart';
import 'api_manager.dart';

class ClientProvider {
  ClientProvider._privateConstructor();

  static final ClientProvider shared = ClientProvider._privateConstructor();

  Future<List<Client>> getAllDb(BuildContext context) async {
    
    final variable = await ClienteRepository.shared.selectAll(tableName: 'cliente');
    return ClientList.fromDb(variable).clientes;
  }


  Future<void> initClientDb() async {
    final response = await ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595",
      pathUrl: "/cliente/buscar",
      type: HttpType.GET,
    );
    final clientList = ClientList.fromService(response);
    ClienteRepository.shared.save(data: clientList.clientes, tableName: 'cliente');
  }

  void saveClientDb(List<dynamic> entrada){
    ClienteRepository.shared.save(data: entrada, tableName: 'cliente');
  }

  Future<void> deleteClient(int idClient) async {
    return ClienteRepository.shared.deleteById(
      tableName: 'cliente', 
      whereClause: 'cliente.id = ?', 
      whereArgs: [idClient]);
  }
 
 }
