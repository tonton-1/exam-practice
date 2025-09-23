import 'package:flutter/material.dart';
import 'questionP6english.dart';
import 'subject_selector.dart';

class Educationlevel extends StatelessWidget {
  const Educationlevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกระดับชั้น')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubjectSelector(),
                  ),
                );
              },
              child: Text('ประถมศึกษาปีที่ 6'),
            ),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: Text('มัธยมศึกษาปีที่ 3'),
            ),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: Text('มัธยมศึกษาปีที่ 6'),
            ),
          ],
        ),
      ),
    );
  }
}
