import 'package:flutter/material.dart';
import '../databases/todo_text_db.dart';
import '../models/modelTextToDo.dart';
import '../modules/module_center.dart';
import '../widgets/card_todo.dart';
import 'tableview_row_todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewManager extends StatefulWidget {
  final ValueChanged<String> parentAction;
  final ValueChanged<ModelTextToDo> parentActionEditToDo;
  int indexObject;
  ListViewManager(
      {super.key,
      required this.indexObject,
      required this.parentAction,
      required this.parentActionEditToDo});

  @override
  State<ListViewManager> createState() => _ListViewManagerState();
}

class _ListViewManagerState extends State<ListViewManager> {
  CardToDo? oCard;
  late ToDoTextDatabase _db;
  @override
  void initState() {
    // TODO: implement initState
    _db = ToDoTextDatabase.instance;
    oCard = ModuleCenter.listCards[widget.indexObject];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollPhysics physics = const ClampingScrollPhysics();
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: physics,
        shrinkWrap: true,
        itemCount: oCard!.oModelCard.listToDo.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(oCard!.oModelCard.listToDo[index].textToDoID.toString()),
            child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),
              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      widget.parentActionEditToDo(
                          oCard!.oModelCard.listToDo[index]);
                      //setState(() {
                      //oCard!.oModelCard.listToDo[index].textToDoName = "";
                      //_db.update(oCard!.oModelCard.listToDo[index]);
                      //});
                      print("edit object");
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    //label: '',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      _db.delete(oCard!.oModelCard.listToDo[index].textToDoID);
                      setState(() {
                        oCard!.oModelCard.listToDo.removeAt(index);
                      });
                      widget.parentAction(
                          oCard!.oModelCard.listToDo.length.toString());
                      print("delete object");
                    },
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    //label: '',
                  ),
                ],
              ),
              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: TableViewRowManager(
                oTextToDo: oCard!.oModelCard.listToDo[index],
                tintColor: oCard!.oModelCard.color,
                parentActionEdit: (value) {
                  widget
                      .parentActionEditToDo(oCard!.oModelCard.listToDo[index]);
                },
              ),
            ),
          );
        });
  }
}
