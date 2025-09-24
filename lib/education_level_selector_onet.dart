import 'package:flutter/material.dart';
import 'question.dart';
import 'subject_selector.dart';

class Educationlevel extends StatelessWidget {
  final String year;
  const Educationlevel({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกระดับชั้น')),
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
                        (context) => SubjectSelector(year: year, grade: 'P6'),
                  ),
                );
              },
              child: Text('ประถมศึกษาปีที่ 6'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SubjectSelector(year: year, grade: 'M3'),
                  ),
                );
              },
              child: Text('มัธยมศึกษาปีที่ 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SubjectSelector(year: year, grade: 'M6'),
                  ),
                );
              },
              child: Text('มัธยมศึกษาปีที่ 6'),
            ),
          ],
        ),
      ),
    );
  }
}
