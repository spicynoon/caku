import 'package:flutter/material.dart';
import '../databases/notes_list_db.dart';
import '../models/modelIcon.dart';
import '../models/modelNotesCard.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
import '../pages/notes_card_manager.dart';
import '../pages/notes_list.dart';
import '../widgets/cupertino_actionsheet.dart';

class CardNote extends StatefulWidget {
  ModelNotesCard oModelCard;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  final ValueChanged<CardNote> parentActionDelete;
  final ValueChanged<CardNote> parentActionEdit;
  CardNote(
      {Key? key,
      required this.oModelCard,
      required this.parentActionDelete,
      required this.parentActionEdit});

  @override
  State<CardNote> createState() => _CardNoteState();
}

class _CardNoteState extends State<CardNote> {
  late NotesListDatabase _db;
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
          builder: (context) => NoteList(
              indexObject: index,
              parentAction: (value) {
                setState(() {
                  widget.oModelCard.notesCardTaskNum = value;
                });
              },
              oModuleCard: ModuleCenter.listNoteCards[index].oModelCard)),
    );
  }

  Future<void> _editDetailCard(int value) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotesCardManager(
                  isEdit: true,
                  oCard: widget.oModelCard,
                  parentActionAdd: (ModelNotesCard oModelCard) {
                    setState(() {
                      widget.oModelCard = oModelCard;
                    });
                  },
                  parentActionEdit: (ModelNotesCard oModelCard) {
                    setState(() {
                      widget.oModelCard = oModelCard;
                      widget
                          .parentActionEdit(ModuleCenter.listNoteCards[index]);
                    });
                  },
                )));
  }

  Future<void> _deleteDetailCard(int value) async {
    widget.parentActionDelete(ModuleCenter.listNoteCards[index]);
  }

  @override
  void initState() {
    index = ModuleCenter.listNoteCards.indexWhere((element) =>
        element.oModelCard.notesCardID == widget.oModelCard.notesCardID);
    _db = NotesListDatabase.instance;
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
                  widget.oModelCard.notesCardName,
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
                      widget.oModelCard.notesCardName,
                      widget.oModelCard.notesCardID);
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
                '${widget.oModelCard.notesCardTaskNum} Notes',
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
        _showDetailCard(widget.oModelCard.notesCardID);
      },
    );
  }
}
