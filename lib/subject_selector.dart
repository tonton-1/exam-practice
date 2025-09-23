import 'package:flutter/material.dart';
import 'questionP6english.dart';

class SubjectSelector extends StatelessWidget {
  const SubjectSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกระดับชั้น')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ExamJsonScreen(),
                //   ),
                // );
              },
              child: Text('ไทย'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamJsonScreen(),
                  ),
                );
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: Text('คณิตศาสตร์'),
            ),
          ],
        ),
      ),
    );
  }
}
