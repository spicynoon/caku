import 'package:caku_app/databases/notes_text_db.dart';
import 'package:caku_app/models/modelTextNotes.dart';
import 'package:caku_app/models/modelNotesCard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesListDatabase {
  static final NotesListDatabase instance = NotesListDatabase._init();
  static Database? _database;

  NotesListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('noteslist.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotesList (
  ${NotesListFields.notesCardID} $idType,
  ${NotesListFields.notesCardName} $integerType,
  ${NotesListFields.notesCardTaskNum} $textType,
  ${NotesListFields.iconID} $integerType,
  ${NotesListFields.color} $integerType
)
''');
  }

  Future _createDB_notesText(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotesText (
  ${NotesTextFields.textNotesID} $idType,
  ${NotesTextFields.textNotesName} $textType,
  ${NotesTextFields.done} $boolType,
)
''');
  }

  Future<ModelNotesCard> create(ModelNotesCard notescard) async {
    final db = await instance.database;

    final id = await db.insert(tableNotesList, notescard.toJson());
    return notescard.copy(notesCardID: id);
  }

  Future<ModelNotesCard> readNotesCard(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotesList,
      columns: NotesListFields.values,
      where: '${NotesListFields.notesCardID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ModelNotesCard.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ModelNotesCard>> readAll() async {
    final db = await instance.database;

    final orderBy = '${NotesListFields.notesCardID} DESC';
    final result = await db.query(tableNotesList, orderBy: orderBy);

    return result.map((json) => ModelNotesCard.fromJson(json)).toList();
  }

  Future<int> update(ModelNotesCard oNotesCard) async {
    final db = await instance.database;

    return db.update(
      tableNotesList,
      oNotesCard.toJson(),
      where: '${NotesListFields.notesCardID} = ?',
      whereArgs: [oNotesCard.notesCardID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    final dbText = NotesTextDatabase.instance;
    dbText.deleteByCardID(id);
    return db.delete(
      tableNotesList,
      where: '${NotesListFields.notesCardID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableNotesList,
    );
  }

  Future<List<ModelNotesCard>> selectDataFromTable() async {
    final db = await instance.database;
    final _db_text = NotesTextDatabase.instance;
    final orderBy = '${NotesListFields.notesCardID} DESC';
    List<Map<String, dynamic>> result =
        await db.query(tableNotesList, orderBy: orderBy);

    List<ModelNotesCard> _objects =
        result.map((json) => ModelNotesCard.fromJson(json)).toList();

    for (var element in _objects) {
      ModelNotesCard oCard = element;
      List<ModelTextNotes> listItem =
          await _db_text.selectDataFromTableNotesText(oCard.notesCardID);
      if (listItem != null) {
        element.listNotes = listItem;
        element.notesCardTaskNum = listItem.length.toString();
      }
    }

    return _objects;
  }
}
