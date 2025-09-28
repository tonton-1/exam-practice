import 'package:flutter/material.dart';
import 'question.dart';

class SelectModeScreen extends StatelessWidget {
  final String? year;
  final String? grade;
  final String? subject;

  const SelectModeScreen({super.key, this.year, this.grade, this.subject});

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
        title: Text('เลือกโหมด   (${showGrade} > ${showSubject} > ${year})'),
        backgroundColor: Color.fromARGB(255, 246, 247, 248),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Title Section
            Center(
              child: Text(
                'เลือกโหมด',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: 8),

            SizedBox(height: 40),

            // Normal Mode Card
            _buildModeCard(
              context: context,
              icon: Icons.timer_off_outlined,
              iconColor: Color(0xFF59b4c0),
              backgroundColor: Colors.white,
              title: 'ปกติ',
              subtitle: 'ทำข้อสอบแบบไม่จับเวลา',
              mode: 'normal',
            ),

            SizedBox(height: 16),

            // Timed Mode Card
            _buildModeCard(
              context: context,
              icon: Icons.timer_outlined,
              iconColor: Color(0xFF59b4c0),
              backgroundColor: Colors.white,
              title: 'จับเวลา',
              subtitle: 'ทำข้อสอบแบบจับเวลา',
              mode: 'timer',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required String mode,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ExamJsonScreen(
                  grade: grade,
                  subject: subject,
                  year: year,
                  mode: mode,
                ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),

            SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
