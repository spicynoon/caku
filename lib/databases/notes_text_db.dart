import 'package:caku_app/models/modelTextNotes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesTextDatabase {
  static final NotesTextDatabase instance = NotesTextDatabase._init();
  static Database? _database;

  NotesTextDatabase._init();

  Future<Database> get database_list async {
    if (_database != null) return _database!;
    _database = await _initDB('noteslist_notestext.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB_notesText);
  }

  Future _createDB_notesText(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotesText (
  ${NotesTextFields.textNotesID} $idType,
  ${NotesTextFields.notesCardID} $intType,
  ${NotesTextFields.textNotesName} $textType,
  ${NotesTextFields.done} $boolType,
  FOREIGN KEY (${NotesTextFields.notesCardID}) REFERENCES noteslist (_id)
)
''');
  }

  Future<ModelTextNotes> createTextNotes(ModelTextNotes notesText) async {
    final db = await instance.database_list;

    final id = await db.insert(tableNotesText, notesText.toJson());
    return notesText.copy(textNotesID: id);
  }

  Future<ModelTextNotes> readTextNotes(int id) async {
    final db = await instance.database_list;

    final maps = await db.query(
      tableNotesText,
      columns: NotesTextFields.values,
      where: '${NotesTextFields.textNotesID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelTextNotes.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> updateTextNotes(ModelTextNotes oNotesText) async {
    final db = await instance.database_list;

    return db.update(
      tableNotesText,
      oNotesText.toJson(),
      where: '${NotesTextFields.textNotesID} = ?',
      whereArgs: [oNotesText.textNotesID],
    );
  }

  Future<int> deleteTextNotes(int id) async {
    final db = await instance.database_list;

    return db.delete(
      tableNotesText,
      where: '${NotesTextFields.textNotesID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByCardID(int id) async {
    final db = await instance.database_list;

    return db.delete(
      tableNotesText,
      where: '${NotesTextFields.notesCardID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllTextNotes() async {
    final db = await instance.database_list;
    return db.delete(
      tableNotesText,
    );
  }

  Future<List<ModelTextNotes>> selectDataFromTableNotesText(int id) async {
    final db = await instance.database_list;
    const orderBy = '${NotesTextFields.textNotesID} ASC';
    final whereCondition = '${NotesTextFields.notesCardID} = ${id}';
    List<Map<String, dynamic>> result =
        await db.query(tableNotesText, orderBy: orderBy, where: whereCondition);

    List<ModelTextNotes> _objects =
        result.map((json) => ModelTextNotes.fromJson(json)).toList();

    return _objects;
  }
}
