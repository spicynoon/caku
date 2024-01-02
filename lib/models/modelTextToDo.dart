final String tableToDoText = 'todotext';

class ModelTextToDo {
  int textToDoID;
  int todoCardID;
  String textToDoName;
  bool done;

  ModelTextToDo(
      {required this.textToDoID,
      required this.todoCardID,
      required this.textToDoName,
      required this.done});

  ModelTextToDo copy({
    int? textToDoID,
    int? todoCardID,
    String? textToDoName,
    bool? done,
  }) =>
      ModelTextToDo(
          textToDoID: textToDoID ?? this.textToDoID,
          todoCardID: todoCardID ?? this.todoCardID,
          textToDoName: textToDoName ?? this.textToDoName,
          done: done ?? this.done);

  static ModelTextToDo fromJson(Map<String, Object?> json) => ModelTextToDo(
      textToDoID: json['_id'] as int,
      todoCardID: json['todoCardID'] as int,
      textToDoName: json['textToDoName'] as String,
      done: json['done'] == 1);

  Map<String, Object?> toJson() => {
        ToDoTextFields.textToDoID: textToDoID,
        ToDoTextFields.todoCardID: todoCardID,
        ToDoTextFields.textToDoName: textToDoName,
        ToDoTextFields.done: done ? 1 : 0,
      };
}

class ToDoTextFields {
  static final List<String> values = [
    textToDoID,
    todoCardID,
    textToDoName,
    done
  ];

  static const String textToDoID = '_id';
  static const String todoCardID = 'todoCardID';
  static const String textToDoName = 'textToDoName';
  static const String done = 'done';
}
