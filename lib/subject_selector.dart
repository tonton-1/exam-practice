import 'package:flutter/material.dart';
import 'question.dart';

class SubjectSelector extends StatelessWidget {
  final String year;
  final String grade;
  const SubjectSelector({super.key, required this.year, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกระวิชา')),
      body: Center(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExamJsonScreen(
                          year: year,
                          grade: grade,
                          subject: 'Thai',
                        ),
                  ),
                );
              },
              child: Text('ไทย'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExamJsonScreen(
                          year: year,
                          grade: grade,
                          subject: 'English',
                        ),
                  ),
                );
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExamJsonScreen(
                          year: year,
                          grade: grade,
                          subject: 'Math',
                        ),
                  ),
                );
              },
              child: Text('คณิตศาสตร์'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExamJsonScreen(
                          year: year,
                          grade: grade,
                          subject: 'Science',
                        ),
                  ),
                );
              },
              child: Text('วิทยาศาสตร์'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExamJsonScreen(
                          year: year,
                          grade: grade,
                          subject: 'Social',
                        ),
                  ),
                );
              },
              child: Text('สังคมศึกษา'),
            ),
          ],
        ),
      ),
    );
  }
}
