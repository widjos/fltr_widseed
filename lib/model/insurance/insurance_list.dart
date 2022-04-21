
import 'package:test/model/insurance/insurance.dart';
import 'package:test/model/model.dart';

class InsuranceList extends Model{

  late List<Insurance> seguros = [];

  InsuranceList.fromService(List<dynamic> data, dynamic resp) : super(resp){
    data.forEach((element) { seguros.add(Insurance(element));});

  }
}