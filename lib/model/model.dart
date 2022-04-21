import 'package:http/http.dart' as http;

abstract class Model {
  late http.Response response;
  
  Model(dynamic resp){
    response = resp;
  }



}