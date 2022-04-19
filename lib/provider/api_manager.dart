import 'dart:convert';
import 'dart:developer';

import 'package:test/model/client/client_list.dart';
import 'package:test/model/model.dart';
import 'package:test/util/app_type.dart';
import 'package:http/http.dart' as http;
import 'package:test/util/model_type.dart';

class ApiManager {
  ApiManager._privateContructor();
  static final ApiManager shared = ApiManager._privateContructor();


  Future<Model?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    required ModelType modelType,
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
      switch(modelType){
        case ModelType.CLIENT:
          return ClientList.fromService(body);
        case ModelType.INSURANSE:
          return null;
         case ModelType.SINISTER:
          return null; 
      }
      
      
    }else{
      log("Error --->  no se obtuvo data");
    }

    return null;
  }
}