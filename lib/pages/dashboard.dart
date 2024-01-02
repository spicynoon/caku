import 'dart:ffi';

import 'package:caku_app/databases/notes_list_db.dart';
import 'package:caku_app/models/modelNotesCard.dart';
import 'package:caku_app/pages/notes_card_manager.dart';
import 'package:caku_app/widgets/card_notes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../databases/todo_list_db.dart';
import '../databases/users_db.dart';
import '../models/modelTextToDo.dart';
import '../models/modelToDoCard.dart';
import '../modules/module_center.dart';
import 'todo_card_manager.dart';
import '../modules/module_colors.dart';
import '../widgets/card_todo.dart';
import '../models/modelUser.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);
  final double addBtnSize = 30;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ToDoListDatabase _db;
  late NotesListDatabase _dbn;
  late UserDatabase _userdb;
  late List<ModelToDoCard> listToDoCard;
  late List<ModelNotesCard> listNotesCard;
  late ModelUser oUser =
      ModelUser(userID: 0, userName: "", email: "", uuid: "");
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenDeviceSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar
          SliverAppBar(
            backgroundColor: ModuleColors.themeColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.asset(
                  'assets/images/logo/logo_icon_x.png',
                ),
              ),
            ),
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: ModuleColors.themeColor,
              ),
              title: Text('C   A   K   U     A   P   P',
                  style: GoogleFonts.rubikMaze()),
            ),
          ),

          // Sliver Items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 0, left: 15, right: 15, top: 15),
              child: Row(
                children: [
                  Container(
                    width: screenDeviceSize / 2,
                    child: Text('Daftar Tugas',
                        style: GoogleFonts.poppins(
                          color: ModuleColors.fontCardColor,
                          fontSize: 20,
                        )),
                  ),
                  AddTaskCategory(screenDeviceSize, context)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: ModuleColors.themeColor,
                  child: Column(
                    children: List<Widget>.from(ModuleCenter.listCards),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 0, left: 15, right: 15, top: 15),
              child: Row(
                children: [
                  Container(
                    width: screenDeviceSize / 2,
                    child: Text('Daftar Catatan',
                        style: GoogleFonts.poppins(
                          color: ModuleColors.fontCardColor,
                          fontSize: 20,
                        )),
                  ),
                  AddNotesCategory(screenDeviceSize, context)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: ModuleColors.themeColor,
                  child: Column(
                    children: List<Widget>.from(ModuleCenter.listNoteCards),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final double screenDeviceSize = MediaQuery.of(context).size.width;
  //   return Scaffold(
  //     appBar: AppBar(
  //         title: const Text('Caku - Catatan Kuliah'),
  //         backgroundColor: ModuleColors.themeColor,
  //         automaticallyImplyLeading: false,
  //         leading: Image.asset(
  //           'assets/images/logo/logo_icon_x.png',
  //           height: 5,
  //           width: 5,
  //         )),
  //     body: SingleChildScrollView(
  //       child: Container(
  //         padding: const EdgeInsets.only(left: 15, top: 15),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   width: screenDeviceSize / 2,
  //                   child: Text(
  //                     'Daftar Tugas',
  //                     style: TextStyle(
  //                         color: ModuleColors.themeColor,
  //                         fontSize: 20,
  //                         fontFamily: 'Kanit'),
  //                   ),
  //                 ),
  //                 AddTaskCategory(screenDeviceSize, context),
  //               ],
  //             ),
  //             Column(
  //               children: List<Widget>.from(ModuleCenter.listCards),
  //             ),
  //             SizedBox(height: 15),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   width: screenDeviceSize / 2,
  //                   child: Text(
  //                     'Daftar Catatan',
  //                     style: TextStyle(
  //                         color: ModuleColors.themeColor,
  //                         fontSize: 20,
  //                         fontFamily: 'Kanit'),
  //                   ),
  //                 ),
  //                 AddNotesCategory(screenDeviceSize, context),
  //               ],
  //             ),
  //             Column(
  //               children: List<Widget>.from(ModuleCenter.listNoteCards),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),

  // bottomNavigationBar: BottomNavigationBar(
  //   items: const [
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.dashboard),
  //       label: 'Dasbor',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.task),
  //       label: 'Tugas',
  //     ),
  //     BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Catatan'),
  //   ],
  //   currentIndex: _selectedIndex,
  //   onTap: (index) {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   },
  // ),
  //   );
  // }

  Container AddTaskCategory(double screenDeviceSize, BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: (screenDeviceSize / 2) - widget.addBtnSize,
      child: GestureDetector(
        child: Icon(
          Icons.add,
          size: widget.addBtnSize,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToDoCardManager(
                isEdit: false,
                oCard: ModelToDoCard(
                  todoCardID: 0,
                  todoCardName: "",
                  todoCardTaskNum: "0",
                  iconID: 0,
                  color: Colors.transparent,
                  listToDo: [],
                ),
                parentActionAdd: (ModelToDoCard oModelCard) {
                  setState(() {
                    addNewList(oModelCard);
                  });
                },
                parentActionEdit: (ModelToDoCard oModelCard) {},
              ),
            ),
          );
          print('click add');
        },
      ),
    );
  }

  Container AddNotesCategory(double screenDeviceSize, BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: (screenDeviceSize / 2) - widget.addBtnSize,
      child: GestureDetector(
        child: Icon(
          Icons.add,
          size: widget.addBtnSize,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesCardManager(
                isEdit: false,
                oCard: ModelNotesCard(
                  notesCardID: 0,
                  notesCardName: "",
                  notesCardTaskNum: "0",
                  iconID: 0,
                  color: Colors.transparent,
                  listNotes: [],
                ),
                parentActionAdd: (ModelNotesCard oModelCard) {
                  setState(() {
                    addNewListNote(oModelCard);
                  });
                },
                parentActionEdit: (ModelNotesCard oModelCard) {},
              ),
            ),
          );
          print('click add');
        },
      ),
    );
  }

  @override
  void initState() {
    _db = ToDoListDatabase.instance;
    _dbn = NotesListDatabase.instance;
    _userdb = UserDatabase.instance;
    getDBToDoList();
    super.initState();
  }

  Future<void> getDBToDoList() async {
    ModuleCenter.listCards = [];
    listToDoCard = await _db.selectDataFromTable();
    List<ModelUser> listUser =
        await _userdb.selectDataFromTableByUUID("userUUID");
    if (listUser.isNotEmpty) {
      oUser = listUser[0];
    }
    int i = 0;
    setState(() {
      if (listToDoCard.length == 0 && oUser.uuid == "") {
        addNewList(ModelToDoCard(
            todoCardID: int.parse(ModuleCenter.genIDByDatetimeNow()),
            todoCardName: "ToDo",
            todoCardTaskNum: "0",
            iconID: 1,
            color: ModuleColors.defualtColorCard,
            listToDo: []));
        oUser.userID = 1;
        oUser.uuid = "userUUID";
        _userdb.create(oUser);
      } else {
        for (var element in listToDoCard) {
          ModuleCenter.listCards.add(CardToDo(
            oModelCard: element,
            parentActionDelete: _cardActionDelete,
            parentActionEdit: _editCardInList,
          ));
          i += 1;
        }
        ModuleCenter.listCards.sort((a, b) =>
            b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
      }
    });
  }

  Future<void> _cardActionDelete(CardToDo oCard) async {
    int index = ModuleCenter.listCards.indexWhere((element) =>
        element.oModelCard.todoCardID == oCard.oModelCard.todoCardID);
    _db.delete(oCard.oModelCard.todoCardID);
    setState(() {
      ModuleCenter.listCards.removeAt(index);
    });
  }

  Future<String> clickSetting() async {
    print('click setting');
    return 'click';
  }

  Future<void> addNewList(ModelToDoCard oModelCard) async {
    ModuleCenter.listCards.add(CardToDo(
      oModelCard: oModelCard,
      parentActionDelete: _cardActionDelete,
      parentActionEdit: _editCardInList,
    ));
    ModuleCenter.listCards.sort(
        (a, b) => b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
    _db.create(oModelCard);
  }

  Future<void> _editCardInList(CardToDo oCard) async {
    int index = ModuleCenter.listCards.indexWhere((element) =>
        element.oModelCard.todoCardID == oCard.oModelCard.todoCardID);
    _db.update(oCard.oModelCard);
    setState(() {
      ModuleCenter.listCards[index] = oCard;
    });
  }

  Future<void> getDBNotesList() async {
    ModuleCenter.listNoteCards = [];
    listNotesCard = await _dbn.selectDataFromTable();
    List<ModelUser> listUser =
        await _userdb.selectDataFromTableByUUID("userUUID");
    if (listUser.isNotEmpty) {
      oUser = listUser[0];
    }
    int i = 0;
    setState(() {
      if (listNotesCard.length == 0 && oUser.uuid == "") {
        addNewListNote(ModelNotesCard(
            notesCardID: int.parse(ModuleCenter.genIDByDatetimeNow()),
            notesCardName: "Notes",
            notesCardTaskNum: "0",
            iconID: 1,
            color: ModuleColors.defualtColorCard,
            listNotes: []));
        oUser.userID = 1;
        oUser.uuid = "userUUID";
        _userdb.create(oUser);
      } else {
        for (var element in listNotesCard) {
          ModuleCenter.listNoteCards.add(CardNote(
            oModelCard: element,
            parentActionDelete: _cardActionDeleteNote,
            parentActionEdit: _editCardInListNote,
          ));
          i += 1;
        }
        ModuleCenter.listNoteCards.sort((a, b) =>
            b.oModelCard.notesCardID.compareTo(a.oModelCard.notesCardID));
      }
    });
  }

  Future<void> _cardActionDeleteNote(CardNote oCardNote) async {
    int index = ModuleCenter.listNoteCards.indexWhere((element) =>
        element.oModelCard.notesCardID == oCardNote.oModelCard.notesCardID);
    _dbn.delete(oCardNote.oModelCard.notesCardID);
    setState(() {
      ModuleCenter.listNoteCards.removeAt(index);
    });
  }

  Future<void> addNewListNote(ModelNotesCard oModelCardNotes) async {
    ModuleCenter.listNoteCards.add(CardNote(
        oModelCard: oModelCardNotes,
        parentActionDelete: _cardActionDeleteNote,
        parentActionEdit: _editCardInListNote));
  }

  Future<void> _editCardInListNote(CardNote oCardNote) async {
    int index = ModuleCenter.listNoteCards.indexWhere((element) =>
        element.oModelCard.notesCardID == oCardNote.oModelCard.notesCardID);
    _dbn.update(oCardNote.oModelCard);
    setState(() {
      ModuleCenter.listNoteCards[index] = oCardNote;
    });
  }
}
