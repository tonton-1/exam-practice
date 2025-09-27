import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'answer_review.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_navigation.dart';

// void main() {
//   // อย่าลืมลบ เอาไว้ทดสอบ
//   runApp(
//     MaterialApp(
//       home: ScoreResult(score: 85, questionCount: 100), // Example score
//     ),
//   );
// }

class ScoreResult extends StatelessWidget {
  final int score;
  final int questionCount; // Example total questions
  final String timeSpent; // New field for time spent
  final int wrongAnswer;
  final String mode;
  final List<Map<String, dynamic>>? questions;
  final List<String>? userAnswers;

  const ScoreResult({
    super.key,
    required this.score,
    this.questionCount = 100,
    this.timeSpent = '00:00:00',
    this.wrongAnswer = 0,
    this.mode = 'normal',
    this.questions,
    this.userAnswers,
  });
  @override
  // ย้อนกลับไปดูคำตอบหลังทำได้
  // บอกแค่ข้อที่ถูก กับ ผิด ไม่ต้องเฉลย
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Debug: Print the user ID
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            user != null
                ? FutureBuilder<DocumentSnapshot>(
                  future:
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        "คะแนนของ ${userData['name'] ?? 'ผู้ใช้'}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    return Text('กำลังโหลด...', style: TextStyle(fontSize: 18));
                  },
                )
                : Text(
                  "คะแนนของคุณ",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(20),
              width: 340,
              height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ถูก', style: TextStyle(fontSize: 17)),

                  Row(
                    children: [
                      Text(
                        '$score/$questionCount',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "ข้อ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.done, color: Colors.green, size: 40),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(20),
              width: 340,
              height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ผิด', style: TextStyle(fontSize: 17)),
                  Row(
                    children: [
                      Text(
                        '$wrongAnswer',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.close, color: Colors.red, size: 40),
                    ],
                  ),
                ],
              ),
            ),
            if (mode == 'timer') ...[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(20),
                width: 340,
                height: 130,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('เวลาที่ใช้ทั้งหมด', style: TextStyle(fontSize: 17)),
                    Row(
                      children: [
                        Text(
                          '$timeSpent',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 99, 171, 242),
                          size: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 20),
            Container(
              width: 340,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 86, 179, 191),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AnswerReview(
                            questions: questions!.cast<Map<String, dynamic>>(),
                            // userAnswers: userAnswers!.cast<String>(),
                            score: score,
                            totalQuestions: questionCount,
                          ),
                    ),
                  );
                },
                child: const Text(
                  'ดูคำตอบ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: 340,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 140, 66),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavigation()),
                    (route) => false, // ลบ route ทั้งหมด
                  );
                },
                child: const Text(
                  'กลับสู่หน้าหลัก',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
