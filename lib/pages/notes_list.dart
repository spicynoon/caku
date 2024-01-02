import 'package:flutter/material.dart';
import '../databases/notes_text_db.dart';
import '../models/modelIcon.dart';
import '../models/modelTextNotes.dart';
import '../models/modelNotesCard.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
import '../widgets/listview_notes.dart';
import '../widgets/tableview_row_notes.dart';

class NoteList extends StatefulWidget {
  ModelNotesCard oModuleCard;
  int indexObject;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  final ValueChanged<String> parentAction;
  List<NotesTableViewRowManager> list = [];
  NoteList({
    Key? key,
    required this.oModuleCard,
    required this.indexObject,
    required this.parentAction,
  });

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  late NotesTextDatabase _db;
  TextEditingController? _textFieldController;
  String noteNew = "";
  Future<void> initDataDrawing() async {
    for (var oTextNotes in widget.oModuleCard.listNotes) {
      widget.list.add(NotesTableViewRowManager(
        oTextNotes: oTextNotes,
        tintColor: widget.oModuleCard.color,
        parentActionEdit: _requestEditWhenClick,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _db = NotesTextDatabase.instance;
    initDataDrawing();
  }

  Future<void> addNewTextList(ModelTextNotes oModelNote) async {
    ModuleCenter.listNoteCards[widget.indexObject].oModelCard.listNotes
        .add(oModelNote);
    _db.createTextNotes(oModelNote);
  }

  Future<void> _requestEditWhenClick(ModelTextNotes oNote) async {
    _displayDialogAddNewNote(context, oNote);
  }

  Future<void> _displayDialogAddNewNote(BuildContext context,
      [ModelTextNotes? oNote]) async {
    bool isEdit = false;
    if (oNote != null) {
      isEdit = true;
    }
    _textFieldController = TextEditingController(
        text: !isEdit ? "" : oNote!.textNotesName.toString());
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(!isEdit ? 'New Note' : 'Edit Note'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                noteNew = value;
              });
            },
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Input your note"),
          ),
          actions: <Widget>[
            MaterialButton(
              color: widget.oModuleCard.color,
              textColor: Colors.black,
              child: const Text('OK'),
              onPressed: () {
                if (noteNew.trim() == "") {
                  return;
                }
                if (isEdit) {
                  setState(() {
                    oNote!.textNotesName = noteNew;
                  });
                  Navigator.pop(context);
                  _db.updateTextNotes(oNote!);
                } else {
                  String _id = ModuleCenter.genIDByDatetimeNow();
                  ModelTextNotes oText = ModelTextNotes(
                      textNotesID: int.parse(_id),
                      notesCardID: widget.oModuleCard.notesCardID,
                      textNotesName: noteNew,
                      done: false);
                  addNewTextList(oText);
                  setState(() {
                    widget.list.add(NotesTableViewRowManager(
                      oTextNotes: oText,
                      tintColor: widget.oModuleCard.color,
                      parentActionEdit: _requestEditWhenClick,
                    ));
                    Navigator.pop(context);
                  });
                  widget.parentAction(ModuleCenter
                      .listNoteCards[widget.indexObject]
                      .oModelCard
                      .listNotes
                      .length
                      .toString());
                }
              },
            ),
          ],
        );
      },
    );
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
                color: Color.fromARGB(255, 229, 229, 229),
              ),
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
                            widget.oModuleCard.notesCardName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(Icons.add),
                        onTap: () {
                          _displayDialogAddNewNote(context, null);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            NotesListViewManager(
              indexObject: widget.indexObject,
              parentAction: (value) {
                widget.parentAction(value);
              },
              parentActionEditNote: (value) {
                _displayDialogAddNewNote(context, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
