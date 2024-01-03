import 'dart:async';

import 'package:caku_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../modules/module_colors.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Menggantikan LaunchScreen dengan LoginPage setelah penundaan
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
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
