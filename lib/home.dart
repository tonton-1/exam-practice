import 'package:flutter/material.dart';
import 'education_level_selector_onet.dart';
import 'subject_selector.dart';
import 'year_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YearSelector()),
                );
              },
              child: Text('ข้อสอบ Onet'),
            ),
          ],
        ),
      ),
    );
  }
}
