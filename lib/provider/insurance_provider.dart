import 'package:flutter/cupertino.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/repository/insurance_repository.dart';
import 'package:test/util/app_type.dart';

class InsuranceProvider {

  InsuranceProvider._privateContructor();

  static final InsuranceProvider shared = InsuranceProvider._privateContructor();

  Future<void> initInsuranceDb() async {
    final response = await ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595",
      pathUrl: "/seguro/buscar",
      type: HttpType.GET,
    );

    final insuranceList = InsuranceList.fromService(response);
    InsuranceRepository.shared.save(data: insuranceList.seguros, tableName: 'seguro');
  }

  Future<List<Insurance>> getAllDb(BuildContext context) async {
    final  result = await InsuranceRepository.shared.selectAll(tableName: 'seguro');
    return InsuranceList.fromDb(result).seguros;
  }

  Future<int> updateRowDb(Map<String ,dynamic> row, int idRow){
    return InsuranceRepository.shared.updateRow(tableName: 'seguro', row: row, whereClause: 'seguro.id = ?', whereArgs: [idRow]);
  }

    Future<dynamic> DeleteTable() async{
    return InsuranceRepository.shared.delete(tableName: 'seguro');
  }

}
