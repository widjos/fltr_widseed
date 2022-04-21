
import 'package:test/model/model.dart';
import 'package:test/model/sinister/sinister.dart';


class SinisterList extends Model{

  late List<Sinister> siniestros = []; 

  SinisterList.fromService(List<dynamic> data, dynamic resp) : super(resp){
    data.forEach((element) {  siniestros.add(Sinister(element));});
    response = resp;
  }
}