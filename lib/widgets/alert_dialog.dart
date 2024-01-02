import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Confirmation AlertDialog"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MaterialButton(
              onPressed: () async {},
              child: const Text(
                "Show Alert",
                style: TextStyle(fontSize: 20.0),
              ),
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
