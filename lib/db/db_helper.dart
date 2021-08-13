
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqllite/model/model_pegawai.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  static Database _database;

  //table & column
  final String tableName = 'tablePegawai';
  final String columnId = 'id';
  final String columnFirstName = 'firstName';
  final String columnLastName = 'lastName';
  final String columnMobileNo = 'mobileNo';
  final String columnEmail = 'email';

  //constructor internal
  DbHelper._internal();

  factory DbHelper() => _instance;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pegawai.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnFirstName TEXT,"
        "$columnLastName TEXT,"
        "$columnMobileNo TEXT,"
        "$columnEmail TEXT )";

    await db.execute(sql);
  }

  Future<int> savePegawai(Pegawai pegawai) async {
    var dbClient = await _db;

    return await dbClient.insert(tableName, pegawai.toMap());
  }

  Future<List> getAllPegawai() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName, columns: [
      columnId,
      columnFirstName,
      columnLastName,
      columnMobileNo,
      columnEmail
    ]);
    return result.toList();
  }

  Future<int> updatePegawai(Pegawai pegawai) async {
    var dbClient = await _db;
    return await dbClient.update(tableName, pegawai.toMap(),
        where: '$columnId = ? ', whereArgs: [pegawai.id]);
  }

  Future<int> deletePegawai(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(tableName, where: '$columnId = ? ', whereArgs: [id]);
  }
}
