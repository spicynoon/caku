import 'package:flutter/material.dart';
import '../databases/todo_text_db.dart';
import '../models/modelIcon.dart';
import '../models/modelTextToDo.dart';
import '../models/modelToDoCard.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
import '../widgets/listview_todo.dart';
import '../widgets/tableview_row_todo.dart';

class ToDoList extends StatefulWidget {
  ModelToDoCard oModuleCard;
  int indexObject;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  final ValueChanged<String> parentAction;
  List<TableViewRowManager> list = [];
  ToDoList(
      {super.key,
      required this.oModuleCard,
      required this.indexObject,
      required this.parentAction});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late ToDoTextDatabase _db;
  TextEditingController? _textFieldController;
  String todoNew = "";
  Future<void> initDataDrawing() async {
    for (var oTextToDo in widget.oModuleCard.listToDo) {
      widget.list.add(TableViewRowManager(
        oTextToDo: oTextToDo,
        tintColor: widget.oModuleCard.color,
        parentActionEdit: _requestEditWhenClick,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _db = ToDoTextDatabase.instance;
    initDataDrawing();
  }

  Future<void> addNewTextList(ModelTextToDo oModelText) async {
    ModuleCenter.listCards[widget.indexObject].oModelCard.listToDo
        .add(oModelText);
    _db.createToDoText(oModelText);
  }

  Future<void> _requestEditWhenClick(ModelTextToDo oToDo) async {
    _displayDialogAddNewTodo(context, oToDo);
  }

  Future<void> _displayDialogAddNewTodo(BuildContext context,
      [ModelTextToDo? oToDo]) async {
    bool isEdit = false;
    if (oToDo != null) {
      isEdit = true;
    }
    _textFieldController = TextEditingController(
        text: !isEdit ? "" : oToDo!.textToDoName.toString());
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(!isEdit ? 'New Reminder' : 'Edit Reminder'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  todoNew = value;
                });
              },
              autofocus: true,
              controller: _textFieldController,
              decoration:
                  const InputDecoration(hintText: "Input your todolist"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: widget.oModuleCard.color,
                textColor: Colors.black,
                child: const Text('OK'),
                onPressed: () {
                  if (todoNew.trim() == "") {
                    return;
                  }
                  if (isEdit) {
                    setState(() {
                      oToDo!.textToDoName = todoNew;
                    });
                    Navigator.pop(context);
                    _db.update(oToDo!);
                  } else {
                    String _id = ModuleCenter.genIDByDatetimeNow();
                    ModelTextToDo oText = ModelTextToDo(
                        textToDoID: int.parse(_id),
                        todoCardID: widget.oModuleCard.todoCardID,
                        textToDoName: todoNew,
                        done: false);
                    addNewTextList(oText);
                    setState(() {
                      widget.list.add(TableViewRowManager(
                        oTextToDo: oText,
                        tintColor: widget.oModuleCard.color,
                        parentActionEdit: _requestEditWhenClick,
                      ));
                      Navigator.pop(context);
                    });
                    widget.parentAction(ModuleCenter
                        .listCards[widget.indexObject]
                        .oModelCard
                        .listToDo
                        .length
                        .toString());
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ModelIcon imgIcon = widget.allIcons
        .firstWhere((icon) => icon.iconID == widget.oModuleCard.iconID);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Icon(imgIcon.icon),
        ),
        backgroundColor: widget.oModuleCard.color,
        iconTheme: IconThemeData(
          color: ModuleColors.fontCardColor, //change your color here
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 229, 229, 229)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 40,
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                widget.oModuleCard.todoCardName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Kanit'),
                              ))),
                      GestureDetector(
                        child: const Icon(Icons.add),
                        onTap: () {
                          _displayDialogAddNewTodo(context, null);
                        },
                      ),
                    ],
                  ),
                ],
              )),
          ListViewManager(
            indexObject: widget.indexObject,
            parentAction: (value) {
              widget.parentAction(value);
            },
            parentActionEditToDo: (value) {
              _displayDialogAddNewTodo(context, value);
            },
          )
        ],
      )),
    );
  }
}
