

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/model/sinister/sinister.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/repository/sinister_repository.dart';
import 'package:test/util/app_type.dart';

class SinisterProvider {

  SinisterProvider._privateConstructor();

  static final SinisterProvider shared = SinisterProvider._privateConstructor();

  Future<List<Sinister>> getAllDb(BuildContext context) async {
      final resultDb = await SinisterRepository.shared.selectAll(tableName: 'siniestro');
      return SinisterList.fromService(resultDb).siniestros;
  }

  Future<void> initSinistroTable() async {
    final response = await ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595", pathUrl: "/siniestro/buscar", type: HttpType.GET);
      final sinisterList = SinisterList.fromService(response);
      SinisterRepository.shared.save(data: sinisterList.siniestros, tableName: 'siniestro');
  }

}

