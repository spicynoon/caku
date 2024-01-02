import 'package:flutter/material.dart';
import '../databases/notes_text_db.dart';
import '../models/modelTextNotes.dart';

class NotesTableViewRowManager extends StatefulWidget {
  ModelTextNotes oTextNotes;
  final ValueChanged<ModelTextNotes> parentActionEdit;
  Color tintColor = Colors.black;
  NotesTableViewRowManager({
    Key? key,
    required this.oTextNotes,
    required this.tintColor,
    required this.parentActionEdit,
  }) : super(key: key);

  @override
  State<NotesTableViewRowManager> createState() =>
      _NotesTableViewRowManagerState();
}

class _NotesTableViewRowManagerState extends State<NotesTableViewRowManager> {
  late NotesTextDatabase _db;

  @override
  void initState() {
    _db = NotesTextDatabase.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    child: widget.oTextNotes.done == false
                        ? SizedBox(
                            height: 30,
                            child: Image.asset(
                              'assets/images/icons/uncheck.png',
                              color: widget.tintColor,
                            ),
                          )
                        : SizedBox(
                            height: 30,
                            child: Image.asset(
                              'assets/images/icons/check-fill.png',
                              color: widget.tintColor,
                            ),
                          ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.oTextNotes.done = !widget.oTextNotes.done;
                      _db.updateTextNotes(widget.oTextNotes);
                    });
                    print(
                        "tap tap! ==> ${widget.oTextNotes.textNotesID} : ${widget.oTextNotes.textNotesName}");
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Text(widget.oTextNotes.textNotesName),
                  onTap: () {
                    widget.parentActionEdit(widget.oTextNotes);
                    print(
                        "tap tap text! ==> ${widget.oTextNotes.textNotesID} : ${widget.oTextNotes.textNotesName}");
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
