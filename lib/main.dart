import 'package:flutter/material.dart';
import '../modules/module_colors.dart';
import '../pages/launch_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caku',
      theme: ThemeData(),
      home: LoginPage(),
      routes: {
        '/home_page': (contex) => LaunchScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
