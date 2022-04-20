import 'dart:convert';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test/model/client/client.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/model/model.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/util/app_type.dart';
import 'package:http/http.dart' as http;
import 'package:test/util/model_type.dart';
import 'package:geolocator/geolocator.dart';

class ApiManager {
  ApiManager._privateContructor();
  static final ApiManager shared = ApiManager._privateContructor();


  Future<Model?> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    required ModelType modelType,
    String? bodyParams,
    Map<String, dynamic>? uriParams
  }) async {
    dynamic uri;
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     uploadPosition(position);
     print("posicion ------ >  ${position.latitude} , ${position.longitude}");

    if(bodyParams!= null){
      uri = Uri.http(baseUrl, pathUrl);
    }else if(uriParams != null){
      uri = Uri.http(baseUrl, pathUrl,uriParams);
    }
    else{
      uri = Uri.http(baseUrl,pathUrl);
    }
      

    late http.Response response;
    switch(type){
      case HttpType.GET:
        response = await http.get(uri);
      break;
      case HttpType.DELETE:
        response = await http.delete(uri);
      break;
      case HttpType.POST:
        response = await http.post(uri,headers: {"Content-Type": "application/json"} ,body: bodyParams);
      break; 
      case HttpType.PUT:
        response = await http.put(uri);     
    }

  
    if((response.statusCode == 200 || response.statusCode== 202 ) && response.bodyBytes.isNotEmpty) {
      final body  = json.decode(response.body);
      switch(modelType){
        case ModelType.CLIENT:
          if (uriParams != null || bodyParams != null){
            return Client.fromService(body);
          }else{
            return ClientList.fromService(body);
          } 
          
         
        case ModelType.INSURANSE:
          return InsuranceList.fromService(body);
         case ModelType.SINISTER:
          return SinisterList.fromService(body); 
      }
      
      
    }else{
      FirebaseCrashlytics.instance.recordError(
        response.statusCode,
        StackTrace.current,
        reason: 'Error en una peticion',
        );
      log("Error --->  no se obtuvo data");

    }

    return null;
  }

  void uploadPosition(Position pos) async {
    final  postImageRef = 
    FirebaseStorage.instance.ref().child("localitation");
    final uploadTask =  await postImageRef.child('localitation/latitude').putString(pos.latitude.toString());

  }

}