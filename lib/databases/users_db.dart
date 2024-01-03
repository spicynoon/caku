import 'package:caku_app/models/modelUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();
  static Database? _database;

  UserDatabase._init();

  Future<Database> get database_list async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB_todoText);
  }

  Future _createDB_todoText(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableUser (
  ${UserFields.userID} $idType,
  ${UserFields.userName} $textType,
  ${UserFields.email} $textType,
  ${UserFields.uuid} $textType
)
''');
  }

  Future<ModelUser> create(ModelUser obj) async {
    final db = await instance.database_list;

    final id = await db.insert(tableUser, obj.toJson());
    return obj.copy(userID: id);
  }

  Future<ModelUser> read(int id) async {
    final db = await instance.database_list;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.userID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelUser.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(ModelUser obj) async {
    final db = await instance.database_list;

    return db.update(
      tableUser,
      obj.toJson(),
      where: '${UserFields.userID} = ?',
      whereArgs: [obj.userID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database_list;

    return db.delete(
      tableUser,
      where: '${UserFields.userID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database_list;
    return db.delete(
      tableUser,
    );
  }

  Future<List<ModelUser>> selectDataFromTableByUUID(String uuid) async {
    final db = await instance.database_list;
    const orderBy = '${UserFields.userID} ASC';
    final whereCondition = '${UserFields.uuid} = "${uuid}"';
    List<Map<String, dynamic>> result =
        await db.query(tableUser, orderBy: orderBy, where: whereCondition);

    List<ModelUser> _objects =
        result.map((json) => ModelUser.fromJson(json)).toList();

    return _objects;
  }
}
