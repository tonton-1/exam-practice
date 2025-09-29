import 'dart:math';

import 'package:flutter/material.dart';
import 'question.dart';
import 'education_level_selector_onet.dart';
import 'question.dart';
import 'selectMode_normal_timer.dart';

// void main() {
//   runApp(MaterialApp(home: YearSelector()));
// }

class YearSelector extends StatelessWidget {
  final String? subject;
  final String? grade;

  const YearSelector({super.key, this.subject, this.grade});

  @override
  Widget build(BuildContext context) {
    String showGrade = '';
    if (grade == 'P6') {
      showGrade = 'ป.6';
    } else if (grade == 'M3') {
      showGrade = 'ม.3';
    } else if (grade == 'M6') {
      showGrade = 'ม.6';
    } else {
      showGrade = grade ?? '';
    }
    String showSubject = '';
    if (subject == 'Thai') {
      showSubject = 'ภาษาไทย';
    } else if (subject == 'English') {
      showSubject = 'ภาษาอังกฤษ';
    } else if (subject == 'Math') {
      showSubject = 'คณิตศาสตร์';
    } else if (subject == 'Science') {
      showSubject = 'วิทยาศาสตร์';
    } else if (subject == 'Social') {
      showSubject = 'สังคมศึกษา';
    } else {
      showSubject = subject ?? '';
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'เลือกปีของข้อสอบ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              "(${showGrade} > ${showSubject})",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 246, 247, 248),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
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
              child: Container(
                width:
                    (MediaQuery.of(context).size.width - 36) /
                    2, // คำนวณให้พอดี 2 คอลัมน์
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '2567',

                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 65, 85),
                          fontSize: 39,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
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
              child: Container(
                width:
                    (MediaQuery.of(context).size.width - 36) /
                    2, // คำนวณให้พอดี 2 คอลัมน์
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '2566',

                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 65, 85),
                          fontSize: 39,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SelectModeScreen(
                          grade: grade,
                          subject: subject,
                          year: '2565',
                        ),
                  ),
                );
              },
              child: Container(
                width:
                    (MediaQuery.of(context).size.width - 36) /
                    2, // คำนวณให้พอดี 2 คอลัมน์
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '2565',

                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 65, 85),
                          fontSize: 39,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
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
              child: Container(
                width:
                    (MediaQuery.of(context).size.width - 36) /
                    2, // คำนวณให้พอดี 2 คอลัมน์
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '2564',

                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 65, 85),
                          fontSize: 39,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
