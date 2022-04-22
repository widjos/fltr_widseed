import 'package:flutter/cupertino.dart';
import 'package:test/model/client/client_list.dart';

import '../util/app_type.dart';
import 'api_manager.dart';

class ClientProvider {
  ClientProvider._privateConstructor();

  static final ClientProvider shared = ClientProvider._privateConstructor();

  Future<List<Client>> getAll(BuildContext context) async {
    final response = await ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595",
      pathUrl: "/cliente/buscar",
      type: HttpType.GET,
    );
    final clientList = ClientList.fromService(response);
    return clientList.clientes;
  }
}
