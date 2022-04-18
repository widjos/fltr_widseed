import 'dart:convert';
import 'dart:developer';

import 'package:test/util/app_type.dart';
import 'package:http/http.dart' as http;
import 'package:test/model/Client.dart';

class ApiManager {
  ApiManager._privateContructor();
  static final ApiManager shared = ApiManager._privateContructor();


  Future<Client?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams
  }) async {
    final uri = Uri.http(baseUrl, pathUrl);

    late http.Response response;
    switch(type){
      case HttpType.GET:
        response = await http.get(uri);
      break;
      case HttpType.DELETE:
        response = await http.delete(uri);
      break;
      case HttpType.POST:
        response = await http.post(uri);
      break; 
      case HttpType.PUT:
        response = await http.put(uri);     
    }

    if(response.statusCode == 200) {
      final body  = json.decode(response.body);
      return Client.fromService(body);
    }else{
      log("Error --->  no se obtuvo data");
    }

    return null;
  }
}