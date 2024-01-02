import 'package:flutter/material.dart';
import '../databases/notes_text_db.dart';
import '../models/modelTextNotes.dart';
import '../modules/module_center.dart';
import '../widgets/card_notes.dart';
import '../widgets/tableview_row_notes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotesListViewManager extends StatefulWidget {
  final ValueChanged<String> parentAction;
  final ValueChanged<ModelTextNotes> parentActionEditNote;
  int indexObject;
  NotesListViewManager({
    Key? key,
    required this.indexObject,
    required this.parentAction,
    required this.parentActionEditNote,
  }) : super(key: key);

  @override
  State<NotesListViewManager> createState() => _NotesListViewManagerState();
}

class _NotesListViewManagerState extends State<NotesListViewManager> {
  CardNote? oCard;
  late NotesTextDatabase _db;

  @override
  void initState() {
    _db = NotesTextDatabase.instance;
    oCard = ModuleCenter.listNoteCards[widget.indexObject];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollPhysics physics = const ClampingScrollPhysics();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: physics,
      shrinkWrap: true,
      itemCount: oCard!.oModelCard.listNotes.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(oCard!.oModelCard.listNotes[index].textNotesID.toString()),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    widget.parentActionEditNote(
                        oCard!.oModelCard.listNotes[index]);
                    print("edit object");
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                ),
                SlidableAction(
                  onPressed: (context) {
                    _db.deleteTextNotes(
                        oCard!.oModelCard.listNotes[index].textNotesID);
                    setState(() {
                      oCard!.oModelCard.listNotes.removeAt(index);
                    });
                    widget.parentAction(
                        oCard!.oModelCard.listNotes.length.toString());
                    print("delete object");
                  },
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: NotesTableViewRowManager(
              oTextNotes: oCard!.oModelCard.listNotes[index],
              tintColor: oCard!.oModelCard.color,
              parentActionEdit: (value) {
                widget.parentActionEditNote(oCard!.oModelCard.listNotes[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
