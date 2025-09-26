import 'package:flutter/material.dart';

class AnswerReview extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final int score;
  final int totalQuestions;

  const AnswerReview({
    super.key,
    required this.questions,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<AnswerReview> createState() => _AnswerReviewState();
}

class _AnswerReviewState extends State<AnswerReview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> correctQuestions = [];
  List<Map<String, dynamic>> incorrectQuestions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _separateQuestions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _separateQuestions() {
    for (int i = 0; i < widget.questions.length; i++) {
      final question = Map<String, dynamic>.from(widget.questions[i]);
      question['originalIndex'] = i; // เก็บหมายเลขข้อเดิม

      final userAnswer = question['selectedAnswer'];
      final correctAnswer = question['correct_answer'];

      if (userAnswer == correctAnswer && userAnswer != null) {
        correctQuestions.add(question);
      } else {
        incorrectQuestions.add(question);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 250, 251),
      appBar: AppBar(
        title: Text('ดูคำตอบ (${widget.score}/${widget.totalQuestions} ข้อ)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              icon: Icon(Icons.check_circle),
              text: 'ข้อที่ถูก (${correctQuestions.length})',
            ),
            Tab(
              icon: Icon(Icons.cancel),
              text: 'ข้อที่ผิด (${incorrectQuestions.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCorrectAnswersTab(), _buildIncorrectAnswersTab()],
      ),
    );
  }

  Widget _buildCorrectAnswersTab() {
    if (correctQuestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'ไม่มีข้อที่ตอบถูก',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              'ลองทำข้อสอบใหม่นะ!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: correctQuestions.length,
      itemBuilder: (context, index) {
        return _buildQuestionCard(correctQuestions[index], true);
      },
    );
  }

  Widget _buildIncorrectAnswersTab() {
    if (incorrectQuestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 80, color: Colors.amber),
            SizedBox(height: 16),
            Text(
              'เยี่ยม! ไม่มีข้อที่ตอบผิด! 🎉',
              style: TextStyle(fontSize: 18, color: Colors.amber[700]),
            ),
            Text(
              'คุณทำได้คะแนนเต็ม!',
              style: TextStyle(fontSize: 14, color: Colors.amber[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: incorrectQuestions.length,
      itemBuilder: (context, index) {
        return _buildQuestionCard(incorrectQuestions[index], false);
      },
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question, bool isCorrectTab) {
    final userAnswer = question['selectedAnswer'];
    final correctAnswer = question['correct_answer'];
    final isCorrect = userAnswer == correctAnswer;
    final imageUrl = question['image'];
    final originalIndex = question['originalIndex'] + 1; // หมายเลขข้อเดิม

    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวข้อคำถาม พร้อมสถานะ
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCorrectTab ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ข้อ $originalIndex',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  isCorrectTab ? Icons.check_circle : Icons.cancel,
                  color: isCorrectTab ? Colors.green : Colors.red,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  isCorrectTab ? 'ถูก' : 'ผิด',
                  style: TextStyle(
                    color: isCorrectTab ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // คำถาม
            Text(
              '${question['question'] ?? ''}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // รูปภาพ (ถ้ามี)
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: Center(child: Text('ไม่สามารถโหลดรูปได้')),
                    );
                  },
                ),
              ),
            ],

            SizedBox(height: 16),

            // แสดงตัวเลือกทั้งหมด
            _buildChoices(
              question['choices'],
              userAnswer,
              correctAnswer,
              isCorrectTab,
            ),

            SizedBox(height: 12),

            // สรุปคำตอบ
            _buildAnswerSummary(
              userAnswer,
              correctAnswer,
              isCorrect,
              originalIndex,
              isCorrectTab,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoices(
    List choices,
    String? userAnswer,
    String correctAnswer,
    bool isCorrectTab,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ตัวเลือก:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        ...List.generate(choices.length, (index) {
          String choice = choices[index];
          bool isUserChoice = choice == userAnswer;
          bool isCorrectChoice = choice == correctAnswer;

          // กำหนดสีและไอคอน
          Color backgroundColor = Colors.grey[50]!;
          Color borderColor = Colors.grey[300]!;
          Color textColor = Colors.black87;
          Widget? icon;

          if (isCorrectChoice) {
            backgroundColor = Colors.green[50]!;
            borderColor = Colors.green[300]!;
            textColor = Colors.green[800]!;
            icon = Icon(Icons.check_circle, color: Colors.green, size: 20);
          }

          if (isUserChoice && !isCorrectChoice) {
            backgroundColor = Colors.red[50]!;
            borderColor = Colors.red[300]!;
            textColor = Colors.red[800]!;
            icon = Icon(Icons.cancel, color: Colors.red, size: 20);
          }

          return Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              children: [
                Text(
                  '${index + 1}. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    choice,
                    style: TextStyle(
                      color: textColor,
                      fontWeight:
                          isUserChoice || isCorrectChoice
                              ? FontWeight.w600
                              : FontWeight.normal,
                    ),
                  ),
                ),
                if (icon != null) icon,
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnswerSummary(
    String? userAnswer,
    String correctAnswer,
    bool isCorrect,
    int questionNumber,
    bool isCorrectTab,
  ) {
    if (userAnswer == null) {
      // ไม่ได้ตอบ
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange[300]!, width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'ข้อ $questionNumber: ไม่ได้ตอบข้อนี้',
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isCorrectTab) {
      // Tab ข้อที่ถูก
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green[300]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'ข้อ $questionNumber: คุณตอบถูก! 🎉',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'คำตอบของคุณ: "$userAnswer" ✓',
              style: TextStyle(color: Colors.green[700], fontSize: 14),
            ),
          ],
        ),
      );
    } else {
      // Tab ข้อที่ผิด
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red[300]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cancel, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'ข้อ $questionNumber: คุณตอบผิด ❌',
                  style: TextStyle(
                    color: Colors.red[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'คำตอบของคุณ: "$userAnswer" ✗',
              style: TextStyle(color: Colors.red[700], fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'คำตอบที่ถูกต้อง: "$correctAnswer" ✓',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }
}
