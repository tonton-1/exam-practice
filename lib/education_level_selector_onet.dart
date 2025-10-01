import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'subject_selector.dart';

// void main() {
//   runApp(MaterialApp(home: Educationlevel()));
// }

class Educationlevel extends StatelessWidget {
  const Educationlevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      appBar: AppBar(
        title: Text('เลือกระดับชั้น'),
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
                    builder: (context) => SubjectSelector(grade: 'P6'),
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
                      Icons.school,
                      size: 64,
                      color: Color.fromARGB(255, 86, 179, 191),
                    ),
                    Spacer(),
                    Flexible(
                      child: Text(
                        'ประถมศึกษาปีที่ 6',
                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 65, 85),

                          fontSize: 18,
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
                    builder: (context) => SubjectSelector(grade: 'M3'),
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
                      Icons.school,
                      size: 64,
                      color: Color.fromARGB(255, 247, 127, 0),
                    ),
                    Spacer(),
                    Text(
                      'มัธยมศึกษาปีที่ 3',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),

                        fontSize: 18,
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
                    builder: (context) => SubjectSelector(grade: 'M6'),
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
                      Icons.school,
                      size: 64,
                      color: Color.fromARGB(255, 51, 65, 85),
                    ),
                    Spacer(),
                    Text(
                      'มัธยมศึกษาปีที่ 6',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 65, 85),

                        fontSize: 18,
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
