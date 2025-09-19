import 'package:flutter/material.dart';
import 'questionP6english.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      home: HomePage(),
      routes: {'/questionP6english': (context) => ExamJsonScreen()},
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/questionP6english');
          },
          child: Text('ข้อสอบ Onet ป.6 ภาษาอังกฤษ'),
        ),
      ),
    );
  }
}
