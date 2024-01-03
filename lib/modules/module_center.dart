// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../customs/icons/app_icons.dart';
import '../models/modelIcon.dart';
import '../models/modelToDoCard.dart';
import '../models/modelUser.dart';
import '../widgets/card_notes.dart';
import '../widgets/card_todo.dart';
import 'package:intl/intl.dart';

class ModuleCenter {
  static ModelUser? oUser;
  static List<ModelIcon> listIcons = [
    ModelIcon(iconID: 1, icon: Icons.work),
    ModelIcon(iconID: 2, icon: Icons.cast_for_education),
    ModelIcon(iconID: 3, icon: Icons.umbrella_sharp),
    ModelIcon(iconID: 4, icon: Icons.favorite),
    ModelIcon(iconID: 5, icon: Icons.headphones),
    ModelIcon(iconID: 6, icon: Icons.home),
    ModelIcon(iconID: 7, icon: Icons.car_repair),
    ModelIcon(iconID: 8, icon: Icons.flight),
    ModelIcon(iconID: 9, icon: Icons.ac_unit),
    ModelIcon(iconID: 10, icon: Icons.run_circle),
    ModelIcon(iconID: 11, icon: Icons.book),
    ModelIcon(iconID: 12, icon: Icons.sports_rugby_rounded),
    ModelIcon(iconID: 13, icon: Icons.alarm),
    ModelIcon(iconID: 14, icon: Icons.call),
    ModelIcon(iconID: 15, icon: Icons.snowing),
    ModelIcon(iconID: 16, icon: Icons.music_note),
    ModelIcon(iconID: 17, icon: Icons.sunny),
    ModelIcon(iconID: 18, icon: AppIcons.icons8_beach_60),
    ModelIcon(iconID: 22, icon: AppIcons.icons8_around_the_globe_60),
    ModelIcon(iconID: 19, icon: AppIcons.directions_bike),
    ModelIcon(iconID: 20, icon: AppIcons.directions_boat),
    ModelIcon(iconID: 21, icon: AppIcons.ac_unit),
    ModelIcon(iconID: 26, icon: AppIcons.pets),
    ModelIcon(iconID: 23, icon: AppIcons.event_seat),
    ModelIcon(iconID: 24, icon: AppIcons.extension),
    ModelIcon(iconID: 25, icon: AppIcons.free_breakfast),
    // add more icons here if you want
  ];
  static List<CardToDo> listCards = [
    /*CardToDo(
      indexOfObject: 0,
      oModelCard: ModelToDoCard(
        todoCardID: 0,
        todoCardName: "ToDo",
        todoCardTaskNum: "0",
        iconID: 1,
        color: Colors.orangeAccent,
        listToDo: [],
      ),
    )*/
  ];
  static List<CardNote> listNoteCards = [
    /*CardToDo(
      indexOfObject: 0,
      oModelCard: ModelToDoCard(
        todoCardID: 0,
        todoCardName: "ToDo",
        todoCardTaskNum: "0",
        iconID: 1,
        color: Colors.orangeAccent,
        listToDo: [],
      ),
    )*/
  ];

  static Color darken(Color color, [double amount = .3]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    var hslDark;
    if (color.red < 50 && color.green < 50 && color.blue < 50) {
      //-- white
      hslDark = hsl.withLightness((hsl.lightness + 1.0).clamp(0.0, 1.0));
    } else {
      hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    }

    return hslDark.toColor();
  }

  static String genIDByDatetimeNow() {
    return DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  }
}
