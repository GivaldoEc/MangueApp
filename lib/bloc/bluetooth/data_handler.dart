import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataHandler {
  static final DataHandler instance = DataHandler._init();

  static Database? _database;

  DataHandler._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('manguedb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {}

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
