
import 'package:test/model/client/client.dart';

import '../model.dart';

class ClientList extends Model {

 late List<Client> clientes = []; 

  ClientList.fromService(List<dynamic> data, dynamic resp)  : super(resp){
    
     response = resp;
      data.forEach((element) {    clientes.add (Client(element, resp));});
  }

}