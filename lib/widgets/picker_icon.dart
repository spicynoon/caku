import 'package:flutter/material.dart';
import '../modules/module_center.dart';
import '../modules/module_colors.dart';
import '../models/modelIcon.dart';

class PickerIcon extends StatefulWidget {
  final ValueChanged<int> parentAction;
  int selectedIconKey;
  PickerIcon(
      {super.key, required this.parentAction, required this.selectedIconKey});

  // selected icon
  // the selected icon is highlighed
  // so it looks different from the others
  IconData? selectedIcon;
  @override
  State<PickerIcon> createState() => _PickerIconState();
}

class _PickerIconState extends State<PickerIcon> {
  @override
  Widget build(BuildContext context) {
    List<ModelIcon> allIcons = ModuleCenter.listIcons;
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 300,
      alignment: Alignment.center,
      // This grid view displays all selectable icons
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 60,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: allIcons.length,
          itemBuilder: (_, index) => Container(
                key: ValueKey(allIcons[index].iconID),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: IconButton(
                    // give the selected icon a different color
                    color: widget.selectedIconKey == allIcons[index].iconID
                        ? ModuleColors.themeColor
                        : Colors.grey,
                    iconSize: 30,
                    icon: Icon(
                      allIcons[index].icon,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.selectedIcon = allIcons[index].icon;
                        widget.selectedIconKey = allIcons[index].iconID;
                      });
                      int iconID = allIcons[index].iconID;
                      widget.parentAction(iconID);
                      //Navigator.of(context).pop();
                    },
                  ),
                ),
              )),
    );
  }
}
