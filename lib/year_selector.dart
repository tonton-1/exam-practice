import 'package:flutter/material.dart';
import 'question.dart';
import 'education_level_selector_onet.dart';
import 'question.dart';
import 'selectMode_normal_timer.dart';

class YearSelector extends StatelessWidget {
  final String? subject;
  final String? grade;

  const YearSelector({super.key, this.subject, this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกปีของข้อสอบ')),
      body: Center(
        child: Column(
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SelectModeScreen(
                          grade: grade,
                          subject: subject,
                          year: '2567',
                        ),
                  ),
                );
              },
              child: Text('2567'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SelectModeScreen(
                          grade: grade,
                          subject: subject,
                          year: '2566',
                        ),
                  ),
                );
              },
              child: Text('2566'),
            ),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: Text('2565'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SelectModeScreen(
                          grade: grade,
                          subject: subject,
                          year: '2564',
                        ),
                  ),
                );
              },
              child: Text('2564'),
            ),
          ],
        ),
      ),
    );
  }
}
