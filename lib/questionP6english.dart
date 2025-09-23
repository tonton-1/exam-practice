import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Exam JSON Demo', home: const ExamJsonScreen());
  }
}

class ExamJsonScreen extends StatefulWidget {
  const ExamJsonScreen({super.key});

  @override
  State<ExamJsonScreen> createState() => _ExamJsonScreenState();
}

class _ExamJsonScreenState extends State<ExamJsonScreen> {
  List<dynamic>? examList;
  List<dynamic>? questions;
  @override
  void initState() {
    super.initState();
    loadExamJson();
  }

  Future<void> loadExamJson() async {
    final String jsonString = await rootBundle.loadString(
      'P62567/P6English2567.json',
    );
    setState(() {
      examList = json.decode(jsonString);
      final List<Map<String, dynamic>> random =
          examList!.map((e) => Map<String, dynamic>.from(e)).toList();

      random.shuffle(Random());
      for (var q in random) {
        if (q['choices'] is List) {
          (q['choices'] as List).shuffle(Random());
        }
      }
      questions = random;
    });
  }

  /*
    อย่าลืม ตั้งจับเวลาระหว่างทำข้อสอบ

    */

  List<dynamic> savedAnswers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam JSON Demo')),
      body:
          examList == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions!.length,
                        itemBuilder: (context, index) {
                          final item = questions![index];
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${item['question'] ?? 'No question'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.asset(
                                  '${item['image']}',
                                  height: 250,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      '',
                                    ); //ตรงนี้ทำให้เว้นบรรทัดก่อน ที่ จะแสดง CHOICE
                                  },
                                ),
                              ],
                            ),

                            subtitle: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (item['choices'] as List).length,
                              itemBuilder: (context, choiceIndex) {
                                final choice = item['choices'][choiceIndex];
                                return Row(
                                  children: [
                                    Radio(
                                      value: choice,
                                      groupValue: item['selectedAnswer'],
                                      onChanged: (value) {
                                        setState(() {
                                          item['selectedAnswer'] = value;

                                          savedAnswers =
                                              questions!
                                                  .map(
                                                    (e) => e['selectedAnswer'],
                                                  )
                                                  .toList();
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${(choiceIndex + 1)}. $choice',
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        maxLines: 5, // ปรับตามต้องการ
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int score = 0;
                        for (int i = 0; i < questions!.length; i++) {
                          final userAnswer = questions![i]['selectedAnswer'];
                          print('User Answer: $userAnswer');
                          final correctAnswer = questions![i]['correct_answer'];
                          print('Correct Answer: $correctAnswer');
                          if (userAnswer == correctAnswer) {
                            score++;
                          }
                        }
                        // แสดงคะแนนหรือผลลัพธ์
                        print('Score: $score / ${questions!.length}');
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('ผลคะแนน'),
                                content: Text(
                                  'คุณได้ $score จาก ${questions!.length} ข้อ',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                        );
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
    );
  }
}
