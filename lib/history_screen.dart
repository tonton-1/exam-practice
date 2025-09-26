import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print('Current User UID: ${user?.uid}');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('ประวัติการทำข้อสอบ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body:
          user == null
              ? _buildNotLoggedIn()
              : Column(
                children: [
                  Container(height: 150, child: buildOverview()),
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

    Color scoreColor =
        percentage >= 80
            ? Colors.green
            : percentage >= 60
            ? Colors.orange
            : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  decoration: BoxDecoration(
                    color: scoreColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: scoreColor),
                  ),
                  child: Text(
                    '$percentage%',
                    style: TextStyle(
                      color: scoreColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildScoreItem(
                  icon: Icons.check_circle,
                  label: 'ถูก',
                  value: '$score',
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                _buildScoreItem(
                  icon: Icons.cancel,
                  label: 'ผิด',
                  value: '${totalQuestions - score}',
                  color: Colors.red,
                ),
                SizedBox(width: 20),
                if (data.containsKey('timeSpent'))
                  if (data['timeSpent'] != '00:00:00') ...[
                    _buildScoreItem(
                      icon: Icons.access_time,
                      label: 'เวลา',
                      value: data['timeSpent'] ?? '00:00:00',
                      color: Colors.blue,
                    ),
                  ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 4),
        Text(
          '$label: $value',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

Widget buildOverview() {
  return Container(
    width: double.infinity,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              width: 100,
              height: 100,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),

                  Text(
                    "15",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Best Score",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              width: 100,
              height: 100,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),

                  Text(
                    "15",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Average",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              width: 130,
              height: 100,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),

                  Text(
                    "00:00:00",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "เฉลี่ยเวลาทั้งหมด",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
