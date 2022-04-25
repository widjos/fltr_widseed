import 'package:sqflite/sqflite.dart';

class TableManager {
  TableManager._privateContructor();

  static final TableManager shared = TableManager._privateContructor();

  Future<void> cliente(Database db) async {
    const String table = '''CREATE TABLE cliente(
       id INTEGER PRIMARY KEY AUTOINCREMENT, 
     dniCl INTEGER,
     nombreCl TEXT,
     password TEXT,
     email TEXT,
     apellido1 TEXT,
     apellido2 TEXT,
     claseVia TEXT,
     nombreVia TEXT,
     numeroVia INTEGER, 
     codPostal INTEGER, 
     ciudad INTEGER, 
     telefono INTEGER, 
     observaciones TEXT
     )''';

    await db.execute(table);
  }

  Future<void> sinister(Database db) async {
    const String tabla = '''CREATE TABLE siniestro(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    idSiniestro INTEGER,
    fechaSiniestro TEXT,
    causas  TEXT,
    aceptado  TEXT,
    indenmizacion TEXT,
    numeroPoliza INTEGER,
    dniPerito INTEGER
    )''';
    await db.execute(tabla);
  }

  Future<void> insurance(Database db) async {
    const String tabla = '''CREATE TABLE seguro(
   id INTEGER PRIMARY KEY AUTOINCREMENT,  
   numeroPoliza INTEGER,
        ramo TEXT,
        fechaInicio TEXT,
        fechaVencimiento TEXT,
        condicionesParticulares  TEXT,
        observaciones  TEXT,
        dniCl INTEGER
    )''';

    await db.execute(tabla);
  }
}
