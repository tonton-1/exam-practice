import 'package:flutter/material.dart';
import 'question.dart';
import 'subject_selector.dart';

class Educationlevel extends StatelessWidget {
  const Educationlevel({super.key});

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
                    builder: (context) => SubjectSelector(grade: 'P6'),
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
                    builder: (context) => SubjectSelector(grade: 'M3'),
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
                    builder: (context) => SubjectSelector(grade: 'M6'),
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
