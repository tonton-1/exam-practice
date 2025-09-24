import 'package:flutter/material.dart';
import 'question.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Navigation Example', home: HomePage());
  }
}
