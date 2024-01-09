import 'dart:io';
import 'package:caku_app/pages/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../pages/launch_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyB3a9NQzIaso78JCgiA0kqQMI8MZ6_-VYw',
          appId: '1:799873178681:android:ae13240db7e40030c381e8',
          messagingSenderId: '799873178681',
          projectId: 'caku-9f00d',
        ))
      : Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caku',
      theme: ThemeData(),
      home: LaunchScreen(),
      routes: {
        '/home_page': (contex) => const Dashboard(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
