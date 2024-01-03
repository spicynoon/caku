import 'package:caku_app/pages/dashboard.dart';
import 'package:flutter/material.dart';
import '../pages/launch_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

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
      routes: {
        '/home_page': (contex) => const Dashboard(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
