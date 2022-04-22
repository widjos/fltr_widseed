import 'package:test/model/client/client.dart';

import '../model.dart';

class ClientList {
  late List<Client> clientes = [];

  ClientList.fromService(List<dynamic> data) {
    for(final item in data){
      clientes.add(Client.fromService(item));
    }
  }
}

class Client {
  late int dniCl;
  late String nombreCl;
  late String email;
  late String password;
  late String apellido1;
  late String apellido2;
  late String claseVia;
  late String nombreVia;
  late int numeroVia;
  late int codPostal;
  late String ciudad;
  late int telefono;
  late String observaciones;

  Client(Map<String, dynamic> data) {
    dniCl = data['dniCl'];
    email = data['email'];
    password = data['password'];
    nombreCl = data['nombreCl'];
    apellido1 = data['apellido1'];
    apellido2 = data['apellido2'];
    claseVia = data['claseVia'];
    nombreVia = data['nombreVia'];
    numeroVia = data['numeroVia'];
    codPostal = data['codPostal'];
    ciudad = data['ciudad'];
    telefono = data['telefono'];
    observaciones = data['observaciones'];
  }

  Client.fromService(Map<String, dynamic>data) {
    dniCl = data['dniCl'];
    email = data['email'];
    password = data['password'];
    nombreCl = data['nombreCl'];
    apellido1 = data['apellido1'];
    apellido2 = data['apellido2'];
    claseVia = data['claseVia'];
    nombreVia = data['nombreVia'];
    numeroVia = data['numeroVia'];
    codPostal = data['codPostal'];
    ciudad = data['ciudad'];
    telefono = data['telefono'];
    observaciones = data['observaciones'];
  }

  Client.fromDb(Map<String, dynamic> data) {
    dniCl = data['dniCl'];
    email = data['email'];
    password = data['password'];
    nombreCl = data['nombreCl'];
    apellido1 = data['apellido1'];
    apellido2 = data['apellido2'];
    claseVia = data['claseVia'];
    nombreVia = data['nombreVia'];
    numeroVia = data['numeroVia'];
    codPostal = data['codPostal'];
    ciudad = data['ciudad'];
    telefono = data['telefono'];
    observaciones = data['observaciones'];
  }

  Map<String, dynamic> toDatabase() => {
    "dniCl": dniCl,
    "nombreCl": nombreCl,
    "password": password,
    "email": email,
    "apellido1": apellido1,
    "apellido2": apellido2,
    "claseVia": claseVia,
    "nombreVia": nombreVia,
    "numeroVia": numeroVia,
    "codPostal": codPostal,
    "ciudad": ciudad,
    "telefono": telefono,
    "observaciones": observaciones
  };
}