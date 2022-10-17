import 'package:mangueapp/repositories/models/bluetooth_message.dart';
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
    const String floatType = 'FLOAT NOT NULL';

    await db.execute('''
CREATE TABLE $tableMessages(
  ${MessageFields.id} $idType,
  ${MessageFields.accX} $floatType,
  ${MessageFields.accY} $floatType,
  ${MessageFields.accZ} $floatType,
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

  Future<BTMessage> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMessages,
      columns: MessageFields.values,
      where: '${MessageFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BTMessage.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<BTMessage>> readAllDB() async {
    final db = await instance.database;

    const String orderBy = '${MessageFields.id} ASC';

    final result = await db.query(tableMessages, orderBy: orderBy);

    return result.map((json) => BTMessage.fromJson(json)).toList();
  }

  /* Update may not be used at all*/
  Future<int> update(BTMessage message) async {
    final db = await instance.database;
    return db.update(
      tableMessages,
      message.toJson(),
      where: '${MessageFields.id} = ?',
      whereArgs: [message.id],
    );
  }

  /* Delete, probably, also won't be used */

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableMessages,
      where: '${MessageFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
