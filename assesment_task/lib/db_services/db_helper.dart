import 'package:assesment_task/db_services/listModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class Db_helper {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'list.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE list(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, subtitle TEXT NOT NULL)");
  }

  // ignore: avoid_types_as_parameter_names
  Future<listModel> insertdata(listModel listmodel) async {
    var dbClient = await db;
    await dbClient!.insert('list', listmodel.toMap());
    return listmodel;
  }

  Future<List<listModel>> getListdata() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('list');
    return queryResult.map((e) => listModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return dbClient!.delete('list', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(listModel listmodel) async {
    var dbClient = await db;
    return dbClient!.update('list', listmodel.toMap(),
        where: 'id = ?', whereArgs: [listmodel.id]);
  }
}
