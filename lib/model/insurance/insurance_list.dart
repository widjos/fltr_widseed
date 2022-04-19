
import 'package:test/model/insurance/insurance.dart';
import 'package:test/model/model.dart';

class InsuranceList implements Model{

  late List<Insurance> seguros = [];

  InsuranceList.fromService(List<dynamic> data){
    data.forEach((element) { seguros.add(Insurance(element));});
  }
}