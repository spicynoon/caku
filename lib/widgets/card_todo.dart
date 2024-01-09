import 'package:flutter/material.dart';
import '../databases/todo_list_db.dart';
import '../models/modelIcon.dart';
import '../models/modelToDoCard.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
import '../pages/todo_card_manager.dart';
import 'todo_list.dart';
import '../widgets/cupertino_actionsheet.dart';

class CardToDo extends StatefulWidget {
  ModelToDoCard oModelCard;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  final ValueChanged<CardToDo> parentActionDelete;
  final ValueChanged<CardToDo> parentActionEdit;
  CardToDo(
      {super.key,
      required this.oModelCard,
      required this.parentActionDelete,
      required this.parentActionEdit});

  @override
  State<CardToDo> createState() => _CardToDoState();
}

class _CardToDoState extends State<CardToDo> {
  late ToDoListDatabase _db;
  int index = 0;
  late TCupertinoActionSheet actsheet = TCupertinoActionSheet(
    parentActionShow: _showDetailCard,
    parentActionDelete: _deleteDetailCard,
    parentActionEdit: _editDetailCard,
  );

  Future<void> _showDetailCard(int value) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ToDoList(
              indexObject: index,
              parentAction: (value) {
                setState(() {
                  widget.oModelCard.todoCardTaskNum = value;
                });
              },
              oModuleCard: ModuleCenter.listCards[index].oModelCard)),
    );
  }

  Future<void> _editDetailCard(int value) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ToDoCardManager(
                  isEdit: true,
                  oCard: widget.oModelCard,
                  parentActionAdd: (ModelToDoCard oModelCard) {
                    setState(() {
                      widget.oModelCard = oModelCard;
                    });
                  },
                  parentActionEdit: (ModelToDoCard oModelCard) {
                    setState(() {
                      widget.oModelCard = oModelCard;
                      widget.parentActionEdit(ModuleCenter.listCards[index]);
                    });
                  },
                )));
  }

  Future<void> _deleteDetailCard(int value) async {
    widget.parentActionDelete(ModuleCenter.listCards[index]);
  }

  @override
  void initState() {
    // TODO: implement initState
    index = ModuleCenter.listCards.indexWhere((element) =>
        element.oModelCard.todoCardID == widget.oModelCard.todoCardID);
    _db = ToDoListDatabase.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenDeviceWidth = MediaQuery.of(context).size.width;
    ModelIcon imgIcon = widget.allIcons
        .firstWhere((icon) => icon.iconID == widget.oModelCard.iconID);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.all(12),
        width: screenDeviceWidth - 30,
        decoration: BoxDecoration(
            color: widget.oModelCard.color,
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          Row(
            children: [
              Icon(
                imgIcon.icon,
                color: ModuleColors.fontCardColor,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: (screenDeviceWidth - 105),
                child: Text(
                  widget.oModelCard.todoCardName,
                  style: TextStyle(
                      color: ModuleColors.fontCardColor,
                      fontSize: 25,
                      fontFamily: 'Kanit'),
                ),
              ),
              GestureDetector(
                child: Container(
                  child: const Icon(Icons.more_horiz),
                ),
                onTap: () {
                  actsheet.showActionSheet(
                      context,
                      widget.oModelCard.todoCardName,
                      widget.oModelCard.todoCardID);
                },
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                '${widget.oModelCard.todoCardTaskNum} Tasks',
                style: TextStyle(
                    color: ModuleColors.fontCardColor,
                    fontSize: 15,
                    fontFamily: 'Kanit'),
              )
            ],
          )
        ]),
      ),
      onTap: () {
        _showDetailCard(widget.oModelCard.todoCardID);
      },
    );
  }
}
