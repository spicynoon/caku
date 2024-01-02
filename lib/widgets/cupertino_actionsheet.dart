import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TCupertinoActionSheet {
  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  late ValueChanged<int> parentActionDelete;
  late ValueChanged<int> parentActionEdit;
  late ValueChanged<int> parentActionShow;

  TCupertinoActionSheet(
      {required this.parentActionDelete,
      required this.parentActionEdit,
      required this.parentActionShow});

  void showActionSheet(BuildContext context, String title, int id) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('${title}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: false,
            onPressed: () {
              Navigator.pop(context);
              parentActionShow(id);
            },
            child:
                const Text('Show List', style: TextStyle(color: Colors.black)),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              parentActionEdit(id);
            },
            child: const Text(
              'Edit List',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              parentActionDelete(id);
            },
            child: const Text('Delete List'),
          ),
        ],
      ),
    );
  }
}
