import 'package:caku_app/auth.dart';
import 'package:caku_app/pages/dashboard.dart';
import 'package:caku_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Dashboard();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
