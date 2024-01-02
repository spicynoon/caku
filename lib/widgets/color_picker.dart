import 'package:flutter/material.dart';
import '../models/modelColor.dart';

class TColorPicker extends StatefulWidget {
  Color selectionColor;
  final ValueChanged<ModelColor> parentActions;
  TColorPicker(
      {super.key, required this.selectionColor, required this.parentActions});

  @override
  State<TColorPicker> createState() => _TColorPickerState();
}

class _TColorPickerState extends State<TColorPicker> {
  List<ModelColor> listColor = [
    ModelColor(keyColor: "#ffd66e", r: 255, g: 215, b: 110, alpha: 1.0),
    ModelColor(keyColor: "#ffae5b", r: 255, g: 174, b: 91, alpha: 1.0),
    ModelColor(keyColor: "#ff7a83", r: 255, g: 122, b: 130, alpha: 1.0),
    ModelColor(keyColor: "#ff8ade", r: 255, g: 138, b: 221, alpha: 1.0),
    ModelColor(keyColor: "#c19cf8", r: 193, g: 156, b: 248, alpha: 1.0),
    ModelColor(keyColor: "#81b7f0", r: 129, g: 183, b: 240, alpha: 1.0),
    ModelColor(keyColor: "#5de2fc", r: 93, g: 226, b: 252, alpha: 1.0),
    ModelColor(keyColor: "#49f594", r: 73, g: 245, b: 147, alpha: 1.0),
    ModelColor(keyColor: "#a1fe93", r: 162, g: 254, b: 147, alpha: 1.0),
    ModelColor(keyColor: "#dae088", r: 218, g: 224, b: 136, alpha: 1.0),
    ModelColor(keyColor: "#ddb3a7", r: 221, g: 179, b: 167, alpha: 1.0)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 200,
      alignment: Alignment.center,
      // This grid view displays all selectable icons
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 60,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 0,
              crossAxisCount: 5,
              mainAxisSpacing: 0),
          itemCount: listColor.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => Container(
                key: ValueKey(listColor[index].keyColor),
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Color.fromRGBO(
                            listColor[index].r,
                            listColor[index].g,
                            listColor[index].b,
                            listColor[index].alpha),
                      ),
                      width: 30,
                      height: 30,
                      child: widget.selectionColor ==
                              Color.fromRGBO(
                                  listColor[index].r,
                                  listColor[index].g,
                                  listColor[index].b,
                                  listColor[index].alpha)
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : Container()),
                  onTap: () {
                    setState(() {
                      widget.selectionColor = Color.fromRGBO(
                          listColor[index].r,
                          listColor[index].g,
                          listColor[index].b,
                          listColor[index].alpha);
                    });
                    ModelColor color = listColor[index];
                    widget.parentActions(color);
                    //Navigator.of(context).pop();
                  },
                )),
              )),
    );
  }
}
