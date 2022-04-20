
import 'package:test/model/model.dart';
import 'package:test/model/sinister/sinister.dart';


class SinisterList implements Model{

  late List<Sinister> siniestros = []; 

  SinisterList.fromService(List<dynamic> data){
    data.forEach((element) {  siniestros.add(Sinister(element));});
  }
}