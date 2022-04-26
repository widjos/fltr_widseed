
import 'package:flutter/cupertino.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/repository/sinister_repository.dart';
import 'package:test/util/app_type.dart';

class SinisterProvider {

  SinisterProvider._privateConstructor();

  static final SinisterProvider shared = SinisterProvider._privateConstructor();

  Future<List<Sinister>> getAllDb(BuildContext context) async {
      final resultDb = await SinisterRepository.shared.selectAll(tableName: 'siniestro');
      return SinisterList.fromDb(resultDb).siniestros;
  }

  Future<void> initSinistroTable() async {
    final response = await ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595", pathUrl: "/siniestro/buscar", type: HttpType.GET);
      final sinisterList = SinisterList.fromService(response);
      SinisterRepository.shared.save(data: sinisterList.siniestros, tableName: 'siniestro');
  }


  Future<void> deleteSinister(int idSiniestro) async {
    return SinisterRepository.shared.deleteById(
      tableName: 'siniestro', 
      whereClause: 'siniestro.id = ?',
      whereArgs: [idSiniestro]
      );
  }

  Future<void> addColumn({required column, required typeIn}) async {
    var count = await SinisterRepository.shared.alterTable(
      tableName: 'siniestro', 
      columnName: column,
      type: typeIn
      );

   print('---------------------> Nueva tabla ------------');
   print(await SinisterRepository.shared.showTable(table: 'siniestro'));

  }
}

