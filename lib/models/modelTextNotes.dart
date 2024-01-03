const String tableNotesText = 'textnotes';

class ModelTextNotes {
  int textNotesID;
  int notesCardID;
  String textNotesName;
  bool done;

  ModelTextNotes({
    required this.textNotesID,
    required this.notesCardID,
    required this.textNotesName,
    required this.done,
  });

  ModelTextNotes copy({
    int? textNotesID,
    int? notesCardID,
    String? textNotesName,
    bool? done,
  }) =>
      ModelTextNotes(
        textNotesID: textNotesID ?? this.textNotesID,
        notesCardID: notesCardID ?? this.notesCardID,
        textNotesName: textNotesName ?? this.textNotesName,
        done: done ?? this.done,
      );

  static ModelTextNotes fromJson(Map<String, Object?> json) => ModelTextNotes(
        textNotesID: json['_id'] as int,
        notesCardID:
            json['notesCardID'] as int, // Ganti sesuai dengan model catatan
        textNotesName: json['textNotesName'] as String,
        done: json['done'] == 1,
      );

  Map<String, Object?> toJson() => {
        NotesTextFields.textNotesID: textNotesID,
        NotesTextFields.notesCardID: notesCardID,
        NotesTextFields.textNotesName: textNotesName,
        NotesTextFields.done: done ? 1 : 0,
      };
}

class NotesTextFields {
  static final List<String> values = [
    textNotesID,
    notesCardID,
    textNotesName,
    done,
  ];

  static const String textNotesID = '_id';
  static const String notesCardID = 'notesCardID';
  static const String textNotesName = 'textNotesName';
  static const String done = 'done';
}
