import 'package:caku_app/models/modelTextToDo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoTextDatabase {
  static final ToDoTextDatabase instance = ToDoTextDatabase._init();
  static Database? _database;

  ToDoTextDatabase._init();

  Future<Database> get database_list async {
    if (_database != null) return _database!;
    _database = await _initDB('todolist_todotext.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB_todoText);
  }

  Future _createDB_todoText(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableToDoText (
  ${ToDoTextFields.textToDoID} $idType,
  ${ToDoTextFields.todoCardID} $intType,
  ${ToDoTextFields.textToDoName} $textType,
  ${ToDoTextFields.done} $boolType,
  FOREIGN KEY (${ToDoTextFields.todoCardID}) REFERENCES todolist (_id)
)
''');
  }

  Future<ModelTextToDo> createToDoText(ModelTextToDo todoText) async {
    final db = await instance.database_list;

    final id = await db.insert(tableToDoText, todoText.toJson());
    return todoText.copy(textToDoID: id);
  }

  Future<ModelTextToDo> readToDoText(int id) async {
    final db = await instance.database_list;

    final maps = await db.query(
      tableToDoText,
      columns: ToDoTextFields.values,
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelTextToDo.fromJson(maps.first);
    } else {
      // ถ้าไม่มีแสดง error
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(ModelTextToDo oTodoText) async {
    final db = await instance.database_list;

    return db.update(
      tableToDoText,
      oTodoText.toJson(),
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [oTodoText.textToDoID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database_list;

    return db.delete(
      tableToDoText,
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByCardID(int id) async {
    final db = await instance.database_list;

    return db.delete(
      tableToDoText,
      where: '${ToDoTextFields.todoCardID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database_list;
    return db.delete(
      tableToDoText,
    );
  }

  Future<List<ModelTextToDo>> selectDataFromTableToDoText(int id) async {
    final db = await instance.database_list;
    final orderBy = '${ToDoTextFields.textToDoID} ASC';
    final whereCondition = '${ToDoTextFields.todoCardID} = ${id}';
    List<Map<String, dynamic>> result =
        await db.query(tableToDoText, orderBy: orderBy, where: whereCondition);

    List<ModelTextToDo> _objects =
        result.map((json) => ModelTextToDo.fromJson(json)).toList();

    return _objects;
  }
}
