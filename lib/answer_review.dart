import 'package:flutter/material.dart';

class AnswerReview extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 250, 251),
      appBar: AppBar(
        title: Text('ดูคำตอบ ($score/$totalQuestions ข้อ)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return _buildQuestionCard(index);
        },
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = questions[index];
    final userAnswer = question['selectedAnswer'];
    final correctAnswer = question['correct_answer'];
    final isCorrect = userAnswer == correctAnswer;
    final imageUrl = question['image'];
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวข้อคำถาม
            _buildQuestionHeader(isCorrect),

            SizedBox(height: 12),

            // คำถาม
            Text(
              '${index + 1}. ${question['question'] ?? ''}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              SizedBox(height: 12),
              Image.network(imageUrl),
            ],
            SizedBox(height: 16),

            // แสดงตัวเลือกต่างๆ
            _buildChoices(question['choices'], userAnswer, correctAnswer),

            SizedBox(height: 12),

            // สรุปคำตอบ
            _buildAnswerSummary(userAnswer, correctAnswer, isCorrect),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionHeader(bool isCorrect) {
    return Row(
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: isCorrect ? Colors.green : Colors.red,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Text(
        //     '$questionNumber',
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        // ),
        SizedBox(width: 12),
        Spacer(),
        Icon(
          isCorrect ? Icons.check_circle : Icons.cancel,
          color: isCorrect ? Colors.green : Colors.red,
          size: 24,
        ),
        SizedBox(width: 8),
        Text(
          isCorrect ? 'ถูก' : 'ผิด',
          style: TextStyle(
            color: isCorrect ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildChoices(List choices, String? userAnswer, String correctAnswer) {
    return Column(
      children: List.generate(choices.length, (index) {
        String choice = choices[index];
        bool isUserChoice = choice == userAnswer;
        bool isCorrectChoice = choice == correctAnswer;

        // กำหนดสีและไอคอน
        Color backgroundColor = Colors.white;

        Color textColor = Colors.black;
        Widget? icon;

        if (isCorrectChoice) {
          backgroundColor = Colors.green[50]!;

          textColor = Colors.green[800]!;
          icon = Icon(Icons.check, color: Colors.green, size: 20);
        } else if (isUserChoice) {
          backgroundColor = Colors.red[50]!;

          textColor = Colors.red[800]!;
          icon = Icon(Icons.close, color: Colors.red, size: 20);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                '${index + 1}. ',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              Expanded(
                child: Text(
                  choice,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (icon != null) icon,
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAnswerSummary(
    String? userAnswer,
    String correctAnswer,
    bool isCorrect,
  ) {
    // if (userAnswer == null) {
    //   // ไม่ได้ตอบ
    //   return Container(
    //     padding: EdgeInsets.all(12),
    //     decoration: BoxDecoration(
    //       color: Colors.orange[50],
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Row(
    //       children: [
    //         Icon(Icons.warning, color: Colors.orange),
    //         SizedBox(width: 8),
    //         Text(
    //           'ไม่ได้ตอบข้อนี้',
    //           style: TextStyle(
    //             color: Colors.orange[800],
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    if (isCorrect) {
      // ตอบถูก
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'คุณตอบถูก!',
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      // ตอบผิด
      return Container(
        // padding: EdgeInsets.all(12),
        // decoration: BoxDecoration(
        //   color: Colors.red[50],
        //   borderRadius: BorderRadius.circular(8),
        // ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       children: [
        //         Icon(Icons.cancel, color: Colors.red),
        //         SizedBox(width: 8),
        //         Text(
        //           'คุณตอบผิด',
        //           style: TextStyle(
        //             color: Colors.red[800],
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 8),
        //     Text(
        //       'คำตอบที่ถูกคือ: $correctAnswer',
        //       style: TextStyle(
        //         color: Colors.green[800],
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // ),
      );
    }
  }
}
