import 'package:caku_app/databases/todo_text_db.dart';
import 'package:caku_app/models/modelTextToDo.dart';
import 'package:caku_app/models/modelToDoCard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoListDatabase {
  static final ToDoListDatabase instance = ToDoListDatabase._init();
  static Database? _database;

  ToDoListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todolist.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableToDoList (
  ${ToDoListFields.todoCardID} $idType,
  ${ToDoListFields.todoCardName} $integerType,
  ${ToDoListFields.todoCardTaskNum} $textType,
  ${ToDoListFields.iconID} $integerType,
  ${ToDoListFields.color} $integerType
)
''');
  }

  Future _createDB_todoText(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableToDoText (
  ${ToDoTextFields.textToDoID} $idType,
  ${ToDoTextFields.textToDoName} $textType,
  ${ToDoTextFields.done} $boolType,
)
''');
  }

  Future<ModelToDoCard> create(ModelToDoCard todocard) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    final id = await db.insert(tableToDoList, todocard.toJson());
    return todocard.copy(todoCardID: id);
  }

  Future<ModelToDoCard> readToDoCard(int id) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    final maps = await db.query(
      tableToDoList,
      columns: ToDoListFields.values,
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelToDoCard.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ModelToDoCard>> readAll() async {
    final db = await instance.database;

    const orderBy = '${ToDoListFields.todoCardID} DESC';
    final result = await db.query(tableToDoList, orderBy: orderBy);

    return result.map((json) => ModelToDoCard.fromJson(json)).toList();
  }

  Future<int> update(ModelToDoCard oTodoCard) async {
    final db = await instance.database;

    return db.update(
      tableToDoList,
      oTodoCard.toJson(),
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [oTodoCard.todoCardID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    final dbText = ToDoTextDatabase.instance;
    dbText.deleteByCardID(id);
    return db.delete(
      tableToDoList,
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableToDoList,
    );
  }

  Future<List<ModelToDoCard>> selectDataFromTable() async {
    final db = await instance.database;
    final _db_text = ToDoTextDatabase.instance;
    const orderBy = '${ToDoListFields.todoCardID} DESC';
    List<Map<String, dynamic>> result =
        await db.query(tableToDoList, orderBy: orderBy);

    List<ModelToDoCard> _objects =
        result.map((json) => ModelToDoCard.fromJson(json)).toList();

    for (var element in _objects) {
      ModelToDoCard oCard = element;
      List<ModelTextToDo> listItem =
          await _db_text.selectDataFromTableToDoText(oCard.todoCardID);
      if (listItem != null) {
        element.listToDo = listItem;
        element.todoCardTaskNum = listItem.length.toString();
      }
    }

    return _objects;
  }
}
