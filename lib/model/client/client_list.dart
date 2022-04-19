import 'package:test/model/client/Client.dart';

import '../model.dart';

class ClientList implements Model {

 late List<Client> clientes = []; 

  ClientList.fromService(List<dynamic> data){
     data.forEach((element) {    clientes.add (Client(element));});
  }

}