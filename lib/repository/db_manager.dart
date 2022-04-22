import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/repository/master_repository.dart';
import 'package:test/repository/table_manager.dart';

class DbManager {
  DbManager._privateConstructor();

  static final DbManager shared = DbManager._privateConstructor();
  factory DbManager() => shared;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory directoryDb = await getApplicationDocumentsDirectory();
    String path = '${directoryDb.path}test_db';

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await TableManager.shared.cliente(db);
    await TableManager.shared.insurance(db);
    await TableManager.shared.sinister(db);
  }
}
