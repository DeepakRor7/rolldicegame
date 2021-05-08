import 'package:flutter/material.dart';
import 'package:rolldicegame/ui/login/LoginUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roll Dice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginUI(),
    );
  }
}

