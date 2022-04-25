
class SinisterList {

  late List<Sinister> siniestros = []; 

  SinisterList.fromService(List<dynamic> data){
    for (var element in data) {  siniestros.add(Sinister.fromService(element));}
  }

  SinisterList.fromDb(List<dynamic> data){
    for (var element in data) { siniestros.add(Sinister.fromDb(element));}
  }
}

class Sinister {
  late int id;
  late int idSiniestro;
  late String fechaSiniestro;
  late String causas;
  late String aceptado;
  late String indenmizacion;
  late int numeroPoliza;
  late int dniPerito;

  Sinister.fromService(dynamic data){
    idSiniestro = data['idSiniestro'];
    fechaSiniestro = data['fechaSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    indenmizacion = data['indenmizacion'];
    numeroPoliza = data['seguro']['numeroPoliza'];
    dniPerito = data['perito']['dniPerito'];
  }

  Sinister.fromDb(dynamic data) {
    id = data['id'];
    fechaSiniestro = data['fechaSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    indenmizacion = data['indenmizacion'];
    numeroPoliza = data['numeroPoliza'];
    dniPerito = data['dniPerito'];
  }


Map<String, dynamic> toDatabase() => {
    "fechaSiniestro" : fechaSiniestro,
    "causas" : causas,
    "aceptado" : aceptado,
    "indenmizacion" : indenmizacion,
    "numeroPoliza" : numeroPoliza,
    "dniPerito" : dniPerito
};

}
