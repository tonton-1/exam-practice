import 'package:flutter/material.dart';
import 'question.dart';
import 'year_selector.dart';

class SubjectSelector extends StatelessWidget {
  final String? grade;
  const SubjectSelector({super.key, this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 247, 248),
        title: Text('เลือกวิชา'),
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
                        (context) =>
                            YearSelector(subject: 'Thai', grade: grade),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu_book,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'ไทย',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                        fontSize: 16,
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
                        (context) =>
                            YearSelector(subject: 'English', grade: grade),
                  ),
                );
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 36) / 2,
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.language,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'อังกฤษ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                        fontSize: 16,
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
                        (context) =>
                            YearSelector(subject: 'Math', grade: grade),
                  ),
                );
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 36) / 2,
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calculate,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'คณิตศาสตร์',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                        fontSize: 16,
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
                        (context) =>
                            ExamJsonScreen(subject: 'Science', grade: grade),
                  ),
                );
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 36) / 2,
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.science,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'วิทยาศาสตร์',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                        fontSize: 16,
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
                        (context) =>
                            YearSelector(subject: 'Social', grade: grade),
                  ),
                );
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 36) / 2,
                height: 150,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.people,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'สังคมศึกษา',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),
                        fontSize: 16,
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
