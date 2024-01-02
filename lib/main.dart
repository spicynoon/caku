import 'package:flutter/material.dart';
import '../modules/module_colors.dart';
import '../pages/launch_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caku',
      theme: ThemeData(),
      home: const LaunchScreen(),
    );
  }
}
