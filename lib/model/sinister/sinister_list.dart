
import 'package:test/model/model.dart';
import 'package:test/model/sinister/sinister.dart';


class SinisterList {

  late List<Sinister> siniestros = []; 

  SinisterList.fromService(List<dynamic> data){
    for (var element in data) {  siniestros.add(Sinister(element));}

  }
}

class Sinister {
  late int idSiniestro;
  late String fechaSiniestro;
  late String causas;
  late String aceptado;
  late String indenmizacion;
  late int numeroPoliza;
  late int dniPerito;

  Sinister(dynamic data){
    idSiniestro = data['idSiniestro'];
    fechaSiniestro = data['fechaSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    indenmizacion = data['indenmizacion'];
    numeroPoliza = data['seguro'];
    dniPerito = data['perito']['dniPerito'];
  }

  Sinister.fromDb(dynamic data) {
    idSiniestro = data['idSiniestro'];
    fechaSiniestro = data['fechaSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    indenmizacion = data['indenmizacion'];
    numeroPoliza = data['seguro']['numeroPoliza'];
    dniPerito = data['perito']['dniPerito'];
  }


Map<String, dynamic> toDatabase() => {
    "idSiniestro" : idSiniestro,
    "fechaSiniestro" : fechaSiniestro,
    "causas" : causas,
    "aceptado" : aceptado,
    "indenmizacion" : indenmizacion,
    "numeroPoliza" : numeroPoliza,
    "dniPerito" : dniPerito
};

}
