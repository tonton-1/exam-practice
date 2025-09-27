import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // Mock login สำหรับ debug
//   await _mockLogin();

//   runApp(
//     MaterialApp(
//       title: 'History Screen Debug',
//       home: HistoryScreen(),
//       debugShowCheckedModeBanner: false, // ← ซ่อน debug banner
//     ),
//   );
// }

// Mock login function
Future<void> _mockLogin() async {
  try {
    // ใช้ user ID ตัวจริงจาก Firebase
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'awds@gmail.com',
      password: '123456',
    );
    print('🔧 Login ด้วย account จริงสำเร็จ');
  } catch (e) {
    // ถ้า login ไม่ได้ ใช้ anonymous
    await FirebaseAuth.instance.signInAnonymously();
    print('🔧 ใช้ Anonymous login แทน');
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('Current User UID: ${user?.uid}');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 248),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 247, 248),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body:
          user == null
              ? _buildNotLoggedIn()
              : Column(
                children: [
                  Container(height: 200, child: buildOverview(user.uid)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ), // ← เพิ่ม padding
                    child: Text(
                      "ประวัติการทำข้อสอบ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign:
                          TextAlign
                              .left, // ← เพิ่ม textAlign (แม้ว่าจะเป็น default)
                    ),
                  ),
                  Expanded(child: _buildHistory(user.uid)),
                ],
              ),
    );
  }

  Widget _buildNotLoggedIn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 100, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            'กรุณาเข้าสู่ระบบเพื่อดูประวัติ',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('exam_results')
              .where('userId', isEqualTo: userId)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.quiz_outlined, size: 100, color: Colors.grey[400]),
                SizedBox(height: 20),
                Text(
                  'ยังไม่มีประวัติการทำข้อสอบ',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final data = doc.data() as Map<String, dynamic>;

            return _buildHistoryItem(data);
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> data) {
    final score = data['score'] ?? 0;
    final totalQuestions = data['totalQuestions'] ?? 0;
    final percentage =
        totalQuestions > 0 ? (score / totalQuestions * 100).round() : 0;
    final completedAt = (data['completedAt'] as Timestamp?)?.toDate();

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data['grade']} ${data['subject']} ${data['year']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      if (completedAt != null)
                        Text(
                          '${completedAt.day}/${completedAt.month}/${completedAt.year} '
                          '${completedAt.hour.toString().padLeft(2, '0')}:'
                          '${completedAt.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                  child: Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 23, 115, 207),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey[300], thickness: 1, height: 1),

          Row(
            mainAxisAlignment:
                (data['timeSpent'] == '00:00:00' || data['timeSpent'] == null)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreItem(label: 'ถูก', value: '$score'),
              SizedBox(width: 20),
              if (data['timeSpent'] == '00:00:00') ...[Spacer()],
              _buildScoreItem(label: 'ผิด', value: '${totalQuestions - score}'),
              SizedBox(width: 20),
              if (data.containsKey('timeSpent'))
                if (data['timeSpent'] != '00:00:00') ...[
                  _buildScoreItem(
                    label: 'เวลา',
                    value: data['timeSpent'] ?? '00:00:00',
                  ),
                ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(width: 4),
          if (label == 'เวลา') ...[
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            SizedBox(width: 4),
          ] else ...[
            Text(
              '$label: ',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
          ],

          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 44, 44, 44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildOverview(String userId) {
  return StreamBuilder<QuerySnapshot>(
    stream:
        FirebaseFirestore.instance
            .collection('exam_results')
            .where('userId', isEqualTo: userId)
            .snapshots(),
    builder: (context, snapshot) {
      // ค่าเริ่มต้น
      int bestScore = 0; //  คะแนนข้อที่ถูกมากที่สุด
      int avgScore = 0;
      String avgTime = "00:00:00";

      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
        final docs = snapshot.data!.docs;
        final results =
            docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        // หาคะแนนข้อที่ถูกมากที่สุด
        final scores = results.map((r) => (r['score'] ?? 0) as int).toList();
        if (scores.isNotEmpty) {
          bestScore = scores.reduce(
            (a, b) => a > b ? a : b,
          ); //  หาค่าสูงสุดจาก score
        }

        // คำนวณคะแนนเปอร์เซ็นต์เฉลี่ย
        final percentages =
            results.map((r) => (r['percentage'] ?? 0) as int).toList();
        if (percentages.isNotEmpty) {
          final totalPercentage = percentages.reduce((a, b) => a + b);
          avgScore = (totalPercentage / percentages.length).round();
        }

        // คำนวณเวลาเฉลี่ย
        final timeSpents =
            results
                .where(
                  (r) => r['timeSpent'] != null && r['timeSpent'] != '00:00:00',
                )
                .map((r) => _parseTimeToSeconds(r['timeSpent']))
                .where((time) => time > 0)
                .toList();

        if (timeSpents.isNotEmpty) {
          final avgTimeSeconds =
              (timeSpents.reduce((a, b) => a + b) / timeSpents.length).round();
          avgTime = _formatSecondsToTime(avgTimeSeconds);
        }
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ผลสรุปคะแนน",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOverviewCard(
                    title: "คะแนนสูงสุด",
                    value: "$bestScore", // ← แสดงจำนวนข้อ + หน่วย ข้อ

                    color: const Color.fromARGB(255, 14, 20, 27),
                  ),
                  _buildOverviewCard(
                    title: "คะแนนเฉลี่ย",
                    value: "$avgScore%", // ใช้เปอร์เซ็นต์เฉลี่ย

                    color: const Color.fromARGB(255, 14, 20, 27),
                  ),
                  _buildOverviewCard(
                    title: "เฉลี่ยเวลา",
                    value: avgTime,

                    color: const Color.fromARGB(255, 14, 20, 27),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Helper widget สำหรับ card แต่ละอัน
Widget _buildOverviewCard({
  required String title,
  required String value,

  required Color color,
}) {
  return Expanded(
    child: Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),

            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper functions สำหรับแปลงเวลา
int _parseTimeToSeconds(String timeString) {
  try {
    final parts = timeString.split(':');
    if (parts.length != 3) return 0;

    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final seconds = int.parse(parts[2]);

    return (hours * 3600) + (minutes * 60) + seconds;
  } catch (e) {
    return 0;
  }
}

String _formatSecondsToTime(int totalSeconds) {
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  return '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}';
}
