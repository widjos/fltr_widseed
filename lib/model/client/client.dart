
import 'package:test/model/model.dart';

class Client extends Model{

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



  Client(dynamic data, dynamic resp): super(resp){
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
    response = resp;

  }

  Client.fromService(dynamic data , dynamic resp) : super(resp){
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
    response = resp;
  }

 
}