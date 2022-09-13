import 'package:mangueapp/resources/models/bluetooth_message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataHandler {
  static final DataHandler instance = DataHandler._init();

  static Database? _database;

  DataHandler._init();

  Future<Database> get database async {
    if (_database != null)
      return _database!; // checks for pre-existing databases

    _database = await _initDB('manguedb.db'); // creates new database
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String integerType = 'INTEGER NOT NULL';
    const String accelerometerType = 'ACCELEROMETER ';

    await db.execute('''
CREATE TABLE $tableMessages(
  ${MessageFields.id} $idType,
  ${MessageFields.accelerometerData} $accelerometerType,
  ${MessageFields.rpm} $integerType,
  ${MessageFields.speed} $integerType,
  ${MessageFields.temperature} $integerType,
  ${MessageFields.flags} $integerType,
  ${MessageFields.timeStamp} $integerType,
)
''');
  }

  // TODO: create query method

  Future create(BTMessage btMessage) async {
    final db = await instance.database;
    final id = await db.insert(tableMessages, btMessage.toJson());

    return btMessage.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
