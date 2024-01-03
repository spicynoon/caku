import 'package:flutter/material.dart';
import '../models/modelToDoCard.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
// ignore: depend_on_referenced_packages
import '../widgets/color_picker.dart';
import '../widgets/picker_icon.dart';
// ignore: depend_on_referenced_packages

class ToDoCardManager extends StatefulWidget {
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  final ValueChanged<ModelToDoCard> parentActionAdd;
  final ValueChanged<ModelToDoCard> parentActionEdit;

  ModelToDoCard oCard;
  bool isEdit;
  ToDoCardManager(
      {super.key,
      required this.parentActionAdd,
      required this.parentActionEdit,
      required this.oCard,
      required this.isEdit});

  @override
  State<ToDoCardManager> createState() => _ToDoCardManagerState();
}

class _ToDoCardManagerState extends State<ToDoCardManager> {
  TextEditingController? _textFieldController;
  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textFieldController =
        TextEditingController(text: widget.oCard.todoCardName.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit' : 'Add New',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: ModuleColors.themeColor,
          actions: [
            TextButton(
              onPressed: () {
                if (widget.oCard.todoCardName.trim() == "" ||
                    widget.oCard.iconID == 0 ||
                    widget.oCard.color == Colors.transparent) {
                  _asyncWarningDialog(context);
                  return;
                }
                // Do something when the user taps the "Done" button
                if (widget.isEdit) {
                  widget.parentActionEdit(widget.oCard);
                } else {
                  var widget2 = widget.oCard;
                  String idCard = ModuleCenter.genIDByDatetimeNow();
                  widget2.todoCardID = int.parse(idCard);
                  widget.parentActionAdd(widget2);
                }
                Navigator.of(context).pop();
                print('Doneeee!');
              },
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Kanit'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 70,
                        child: Center(
                            child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                transformAlignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 216, 216, 216),
                                        style: BorderStyle.solid)),
                                width: MediaQuery.of(context).size.width - 40,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your category name',
                                  ),
                                  controller: _textFieldController,
                                  onChanged: (text) {
                                    widget.oCard.todoCardName = text.toString();
                                  },
                                )))),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Color',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Kanit'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 216, 216, 216),
                                style: BorderStyle.solid)),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 200,
                        child: Center(
                            child: Container(
                                transformAlignment: Alignment.topCenter,
                                width: MediaQuery.of(context).size.width - 40,
                                child: TColorPicker(
                                    parentActions: (value) {
                                      widget.oCard.color = Color.fromRGBO(
                                          value.r,
                                          value.g,
                                          value.b,
                                          value.alpha);
                                    },
                                    selectionColor: widget.oCard.color)))),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Icon',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Kanit'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 300,
                        child: Center(
                            child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                transformAlignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            const Color.fromARGB(255, 216, 216, 216),
                                        style: BorderStyle.solid)),
                                width: MediaQuery.of(context).size.width - 40,
                                child: PickerIcon(
                                  selectedIconKey: widget.oCard.iconID,
                                  parentAction: (value) {
                                    widget.oCard.iconID = value;
                                    print('==> ${value}');
                                  },
                                )))),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            //-- dismiss keyboard
            widget.oCard.todoCardName = _textFieldController!.text.toString();
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ));
  }

  Future<void> _asyncWarningDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content:
              const Text('Please complate your category info before add new.'),
          actions: <Widget>[
            MaterialButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
