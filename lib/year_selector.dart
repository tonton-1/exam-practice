import 'package:flutter/material.dart';
import 'question.dart';
import 'education_level_selector_onet.dart';

class YearSelector extends StatelessWidget {
  const YearSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เลือกปีของข้อสอบ')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Educationlevel(year: '2567'),
                  ),
                );
              },
              child: Text('2567'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ,
                //   ),
                // );
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
                    builder: (context) => const Educationlevel(year: '2564'),
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
