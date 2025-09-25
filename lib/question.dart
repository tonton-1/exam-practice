import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'score_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _col = FirebaseFirestore.instance
    .collection('exams')
    .doc('2567')
    .collection('grades')
    .doc('P6')
    .collection('subjects')
    .doc('English')
    .collection('questions')
    .orderBy('createdAt');
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Exam JSON Demo', home: const ExamJsonScreen());
  }
}

class ExamJsonScreen extends StatefulWidget {
  final String? year;
  final String? grade;
  final String? subject;
  final String? mode; // New parameter for mode
  const ExamJsonScreen({
    super.key,
    this.year,
    this.grade,
    this.subject,
    this.mode,
  });

  @override
  State<ExamJsonScreen> createState() => _ExamJsonScreenState();
}

class _ExamJsonScreenState extends State<ExamJsonScreen> {
  int wrongAnswer = 0;
  List<Map<String, dynamic>>? examList;
  List<Map<String, dynamic>>? questions;
  Timer? _timer;
  int _seconds = 0;
  bool isLoading = true;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void initState() {
    super.initState();
    // loadExamJson();
    loadExamFromFirestore();
    if (widget.mode == 'timer') {
      _startTimer();
    }
    print(
      'Year: ${widget.year}, Grade: ${widget.grade}, Subject: ${widget.subject}',
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // String getJsonPath() {
  //   print(' data ${widget.grade}, ${widget.subject} ${widget.year}');
  //   /*อย่าลืมเพิ่ม json ใน pubspec.yaml*/
  //   if (widget.year == '2567' &&
  //       widget.grade == 'P6' &&
  //       widget.subject == 'English') {
  //     return 'P62567/P6English2567.json';
  //   } else if (widget.year == '2567' &&
  //       widget.grade == 'P6' &&
  //       widget.subject == 'Thai') {
  //     return 'P62567/P6Thai2567.json';
  //   } else if (widget.year == '2567' &&
  //       widget.grade == 'M3' &&
  //       widget.subject == 'English') {
  //     return 'M32567/M3English2567.json';
  //   } else if (widget.year == '2567' &&
  //       widget.grade == 'M3' &&
  //       widget.subject == 'Science') {
  //     return 'M32567/M3Science2567.json';
  //   } else if (widget.year == '2567' &&
  //       widget.grade == 'M3' &&
  //       widget.subject == 'Thai') {
  //     return 'M32567/M3Thai2567.json';
  //   } else if (widget.year == '2567' &&
  //       widget.grade == 'M3' &&
  //       widget.subject == 'Math') {
  //     return 'M32567/M3Math2567.json';
  //   } else if (widget.year == '2564' && /* ม6 Social  2564 */
  //       widget.grade == 'M6' &&
  //       widget.subject == 'Social') {
  //     return 'M62564/M6social2564.json';
  //   }
  //   return ''; // default
  //   // } else if (widget.grade == 'M3' && widget.subject == 'Thai') {
  //   //   return 'M32567/M3Thai2567.json'; // สมมติเป็น path ของ M3 Thai
  //   // }
  //   // // เพิ่ม condition อื่นๆ ตามต้องการ
  //   // return 'P62567/P6English2567.json'; // default
  // }

  // Future<void> loadExamJson() async {
  //   final String path = getJsonPath();
  //   final String jsonString = await rootBundle.loadString(path);
  //   setState(() {
  //     examList = json.decode(jsonString);
  //     final List<Map<String, dynamic>> random =
  //         examList!.map((e) => Map<String, dynamic>.from(e)).toList();

  //     random.shuffle(Random());
  //     for (var q in random) {
  //       if (q['choices'] is List) {
  //         (q['choices'] as List).shuffle(Random());
  //       }
  //     }
  //     questions = random;
  //   });
  // }

  Future<void> loadExamFromFirestore() async {
    setState(() {
      isLoading = true;
    });

    try {
      // สร้าง document ID จาก grade_subject_year
      String docId = '${widget.grade}_${widget.subject}_${widget.year}';
      print('Loading from Firestore: $docId');

      // เรียกข้อมูลจาก Firebase
      QuerySnapshot questionsSnapshot =
          await FirebaseFirestore.instance
              .collection('grades')
              .doc(widget.grade)
              .collection('subjects')
              .doc(widget.subject)
              .collection('years')
              .doc(widget.year)
              .collection('questions')
              // .orderBy('createdAt') // เรียงตาม createdAt
              .get();

      if (questionsSnapshot.docs.isEmpty) {
        print('No questions found for $docId');
        setState(() {
          questions = [];

          examList = [];
          isLoading = false;
        });
        return;
      }

      // แปลงข้อมูลจาก Firebase
      List<Map<String, dynamic>> loadedQuestions =
          questionsSnapshot.docs
              .map(
                (doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>},
              )
              .toList();

      // สุ่มคำถามและตัวเลือก (เหมือนเดิม)
      loadedQuestions.shuffle(Random());
      for (var q in loadedQuestions) {
        if (q['choices'] is List) {
          (q['choices'] as List).shuffle(Random());
        }
      }

      print('Loaded ${loadedQuestions.length} questions from Firebase');

      setState(() {
        questions = loadedQuestions;
        print(questions![0]['question']);
        examList = loadedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading from Firestore: $e');
      setState(() {
        questions = [];
        examList = [];
        isLoading = false;
      });

      // แสดง error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('เกิดข้อผิดพลาด'),
                content: Text('ไม่สามารถโหลดข้อสอบได้: $e'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ตกลง'),
                  ),
                ],
              ),
        );
      }
    }
  }

  /*
    อย่าลืม เปลี่ยน ให้เลือก โหมดจับเวลากับไมจับเวลา

    */

  List<dynamic> savedAnswers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Exam JSON Demo'),
            SizedBox(width: 20),
            if (widget.mode == 'timer') ...[
              Icon(Icons.timer),
              SizedBox(width: 10),
              Text(_formatTime(_seconds)),
            ],
          ],
        ),
      ),
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
                        _timer?.cancel(); // หยุดจับเวลาเมื่อกด Submit
                        int score = 0;
                        for (int i = 0; i < questions!.length; i++) {
                          final userAnswer = questions![i]['selectedAnswer'];
                          print('User Answer: $userAnswer');
                          final correctAnswer = questions![i]['correct_answer'];
                          print('Correct Answer: $correctAnswer');
                          if (userAnswer == correctAnswer) {
                            score++;
                          } else {
                            wrongAnswer++;
                          }
                        }
                        // แสดงคะแนนหรือผลลัพธ์
                        print('Score: $score / ${questions!.length}');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ScoreResult(
                                  wrongAnswer: wrongAnswer,
                                  score: score,
                                  questionCount: questions!.length,
                                  timeSpent: _formatTime(
                                    _seconds,
                                  ), // ส่งเวลาที่ใช้ไปด้วย
                                  mode: widget.mode!,
                                  questions:
                                      questions!.cast<Map<String, dynamic>>(),
                                  userAnswers: savedAnswers.cast<String>(),
                                ),
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
