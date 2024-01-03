import 'dart:ui';
import '../models/modelTextNotes.dart';

const String tableNotesList = 'noteslist';

class ModelNotesCard {
  int notesCardID;
  String notesCardName;
  String notesCardTaskNum;
  int iconID;
  Color color;

  List<ModelTextNotes> listNotes;

  ModelNotesCard({
    required this.notesCardID,
    required this.notesCardName,
    required this.notesCardTaskNum,
    required this.iconID,
    required this.color,
    required this.listNotes,
  });

  void setListNotes(ModelTextNotes newObject) {
    listNotes.add(newObject);
  }

  ModelNotesCard copy({
    int? notesCardID,
    String? notesCardName,
    String? notesCardTaskNum,
    int? iconID,
    Color? color,
    List<ModelTextNotes>? listNotes,
  }) =>
      ModelNotesCard(
        notesCardID: notesCardID ?? this.notesCardID,
        notesCardName: notesCardName ?? this.notesCardName,
        notesCardTaskNum: notesCardTaskNum ?? this.notesCardTaskNum,
        iconID: iconID ?? this.iconID,
        color: color ?? this.color,
        listNotes: listNotes ?? this.listNotes,
      );

  static ModelNotesCard fromJson(Map<String, Object?> json) => ModelNotesCard(
        notesCardID: json['_id'] as int,
        notesCardName: json['notesCardName'] as String,
        notesCardTaskNum: json['notesCardTaskNum'] as String,
        iconID: json['iconID'] as int,
        color: Color(json['color'] as int),
        listNotes: [],
      );

  Map<String, Object?> toJson() => {
        NotesListFields.notesCardID: notesCardID,
        NotesListFields.notesCardName: notesCardName,
        NotesListFields.notesCardTaskNum: notesCardTaskNum,
        NotesListFields.iconID: iconID,
        NotesListFields.color: color.value,
      };
}

//-- for sqlite db
class NotesListFields {
  static final List<String> values = [
    notesCardID,
    notesCardName,
    notesCardTaskNum,
    iconID,
    color,
  ];

  static const String notesCardID = '_id';
  static const String notesCardName = 'notesCardName';
  static const String notesCardTaskNum = 'notesCardTaskNum';
  static const String iconID = 'iconID';
  static const String color = 'color';
}
