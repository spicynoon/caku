import 'dart:async';

import 'package:flutter/material.dart';
import '../modules/module_colors.dart';

import 'dashboard.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: 500, // specify the height of the container
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/images/vectors/open_page_x.gif',
                  height: 330,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: ModuleColors.themeColor,
                      fontSize: 50,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Kanit'),
                  child: const Text('Catatan Kuliah'),
                ),
              ),
            ])),
      ),
    );
  }
}
