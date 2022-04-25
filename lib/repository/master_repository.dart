import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/repository/db_manager.dart';

abstract class MasterRepository{
  Future<dynamic> save({ required List<dynamic> data , required String  tableName }) async{
    Database dbManager = await DbManager().db;

    Batch batch = dbManager.batch();
    for( final item in data){
      batch.insert(tableName, item.toDatabase());
    }

    return batch.commit();
  }


  Future<dynamic> delete({required String tableName}) async {
    Database dbManager = await DbManager().db;
    dbManager.delete(tableName);

  }

  Future<dynamic> deleteById({
    required tableName,
    required String whereClause,
    required List<int> whereArgs, 
    }) async {
    Database dbManager = await DbManager().db;
    dbManager.delete(tableName, where: whereClause, whereArgs: whereArgs );
  }



  Future<List<Map<String, dynamic>>> selectAll({required String tableName}) async {
    Database dbManager = await DbManager().db;

    return await dbManager.query(tableName);
  }

  Future<List<Map<String ,dynamic>>> selectWhere({
    required String tableName,
    required String  whereClause,
    required List<String> whereArgs,
  }) async{
    Database dbManager = await DbManager().db;
    return await dbManager.query(tableName, where: whereClause, whereArgs:  whereArgs);
  }

  Future<int> updateRow({
     required String tableName,
     required Map<String,dynamic> row,
     required String whereClause,
     required List<int> whereArgs,
    }) async {
      Database dbMager = await DbManager().db;
      return await dbMager.update(tableName, row, where: whereClause, whereArgs: whereArgs);

    }

  Future<dynamic> alterTable({
    required String tableName,
    required String columnName,
    required String type,
  })async {
    Database dbManager = await DbManager().db;
    return  dbManager.execute('ALTER TABLE $tableName ADD COLUMN $columnName $type;');

  }

  Future<dynamic> showTable({
    required String table,
  }) async {
    Database dbManager = await DbManager().db;
    return dbManager.query(table);
  }

   
}