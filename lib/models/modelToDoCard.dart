import 'dart:ui';
import '../models/modelTextToDo.dart';

const String tableToDoList = 'todolist';

class ModelToDoCard {
  int todoCardID;
  String todoCardName;
  String todoCardTaskNum;
  int iconID;
  Color color;

  List<ModelTextToDo> listToDo;

  ModelToDoCard(
      {required this.todoCardID,
      required this.todoCardName,
      required this.todoCardTaskNum,
      required this.iconID,
      required this.color,
      required this.listToDo});

  void setListToDo(ModelTextToDo newObject) {
    listToDo.add(newObject);
  }

  ModelToDoCard copy(
          {int? todoCardID,
          String? todoCardName,
          String? todoCardTaskNum,
          int? iconID,
          Color? color,
          List<ModelTextToDo>? listToDo}) =>
      ModelToDoCard(
          todoCardID: todoCardID ?? this.todoCardID,
          todoCardName: todoCardName ?? this.todoCardName,
          todoCardTaskNum: todoCardTaskNum ?? this.todoCardTaskNum,
          iconID: iconID ?? this.iconID,
          color: color ?? this.color,
          listToDo: listToDo ?? this.listToDo);

  static ModelToDoCard fromJson(Map<String, Object?> json) => ModelToDoCard(
        todoCardID: json['_id'] as int,
        todoCardName: json['todoCardName'] as String,
        todoCardTaskNum: json['todoCardTaskNum'] as String,
        iconID: json['iconID'] as int,
        color: Color(json['color'] as int),
        listToDo: [],
      );

  Map<String, Object?> toJson() => {
        ToDoListFields.todoCardID: todoCardID,
        ToDoListFields.todoCardName: todoCardName,
        ToDoListFields.todoCardTaskNum: todoCardTaskNum,
        ToDoListFields.iconID: iconID,
        ToDoListFields.color: color.value
      };
}

//-- for sqlite db
class ToDoListFields {
  static final List<String> values = [
    todoCardID,
    todoCardName,
    todoCardTaskNum,
    iconID,
    color
  ];

  static const String todoCardID = '_id';
  static const String todoCardName = 'todoCardName';
  static const String todoCardTaskNum = 'todoCardTaskNum';
  static const String iconID = 'iconID';
  static const String color = 'color';
}
