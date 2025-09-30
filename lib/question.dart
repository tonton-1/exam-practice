import 'dart:async';
//import 'dart:convert';
import 'main_navigation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'score_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_radio/easy_radio.dart';
import 'package:lottie/lottie.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// final _col = FirebaseFirestore.instance
//     .collection('exams')
//     .doc('2567')
//     .collection('grades')
//     .doc('P6')
//     .collection('subjects')
//     .doc('English')
//     .collection('questions')
//     .orderBy('createdAt');
// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Exam', home: const ExamJsonScreen());
//   }
// }

class ExamJsonScreen extends StatefulWidget {
  final String? year;
  final String? grade;
  final String? subject;
  final String? mode;
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
  bool _isTimerVisible = true;
  bool _showLottieAnimation = true;

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  void initState() {
    super.initState();
    // loadExamJson();
    loadExamFromFirestore();
    _initializeExam();

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

  Future<void> _initializeExam() async {
    await loadExamFromFirestore();

    if (widget.mode == 'timer' &&
        !isLoading &&
        questions != null &&
        questions!.isNotEmpty) {
      _startTimer();
      print('🕐 Timer started');
    }
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
      _showLottieAnimation = true;
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
        await Future.delayed(Duration(milliseconds: 550));
        setState(() {
          questions = [];

          examList = [];
          isLoading = false;
        });
        return;
      }
      await Future.delayed(Duration(milliseconds: 550));

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

  List<dynamic> savedAnswers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 253, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close), // ← เปลี่ยนเป็นไอคอนบ้าน
          onPressed: () async {
            // แสดง warning ก่อนออกจากหน้า
            bool? confirm = await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text('แจ้งเตือน'),
                    content: Text(
                      'คุณต้องการออกจากหน้านี้หรือไม่? คำตอบของคุณจะไม่ถูกบันทึก',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),

                        child: Text('ออก'),
                      ),
                    ],
                  ),
            );
            if (confirm == true) {
              _timer?.cancel(); // หยุด timer
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainNavigation(),
                ), // ← ไปหน้า HomePage
                (Route<dynamic> route) => false, // ลบ route stack ทั้งหมด
              );
            }
          },
        ),
        backgroundColor: Color.fromARGB(255, 252, 253, 255),
        title: Row(
          children: [
            Text('Exam', style: TextStyle(fontSize: 18)),
            SizedBox(width: 100),
            if (widget.mode == 'timer') ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isTimerVisible = !_isTimerVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isTimerVisible
                            ? Icons.timer
                            : Icons.timer_off, // ← เปลี่ยนไอคอน
                        color:
                            _isTimerVisible
                                ? Color.fromARGB(255, 89, 180, 192)
                                : Colors.grey,
                      ),
                      if (_isTimerVisible) ...[
                        SizedBox(width: 5),
                        Text(
                          _formatTime(_seconds),
                          style: TextStyle(
                            color: Color.fromARGB(255, 89, 180, 192),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      body:
          isLoading || !_showLottieAnimation
              ? Center(
                child: Lottie.network(
                  width: 150,
                  height: 150,
                  'https://lottie.host/640a74ff-df00-40de-b719-584aead33105/2GafYjbCmH.json',
                ),
              )
              : (questions == null || questions!.isEmpty)
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'ไม่พบข้อสอบ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'กรุณาเลือกข้อสอบอื่น',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
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
                                  if (item['image'] != null &&
                                      item['image'].toString().isNotEmpty)
                                    Image.asset(
                                      '${item['image']}',
                                      height: 250,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return SizedBox();
                                      },
                                    ),
                                ],
                              ),

                              subtitle: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: (item['choices'] as List).length,
                                itemBuilder: (context, choiceIndex) {
                                  final choice = item['choices'][choiceIndex];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        EasyRadio(
                                          value: choice,
                                          groupValue: item['selectedAnswer'],
                                          onChanged: (value) {
                                            setState(() {
                                              item['selectedAnswer'] = value;

                                              savedAnswers =
                                                  questions!
                                                      .map(
                                                        (e) =>
                                                            e['selectedAnswer'],
                                                      )
                                                      .toList();
                                            });
                                          },
                                          activeBorderColor: Color.fromARGB(
                                            255,
                                            89,
                                            180,
                                            192,
                                          ),
                                          dotRadius: 10.0,
                                          radius: 10.0,
                                          dotStyle: DotStyle.circle(),
                                          dotColor: Color.fromARGB(
                                            255,
                                            89,
                                            180,
                                            192,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ), // ระยะห่างข้อความกับ radio
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                              4,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: Text(
                                              '${(choiceIndex + 1)}. $choice',
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              maxLines: 5, // ปรับตามต้องการ
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                  255,
                                                  58,
                                                  58,
                                                  58,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 89, 180, 192),
                        minimumSize: Size(double.infinity, 50), //
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _timer?.cancel(); // หยุดจับเวลาเมื่อกด Submit
                        int score = 0;
                        //  ตรวจว่ามีข้อที่ยังไม่ได้ตอบหรือไม่
                        bool hasUnanswered = questions!.any(
                          (q) =>
                              q['selectedAnswer'] == null ||
                              q['selectedAnswer'].toString().isEmpty,
                        );
                        if (hasUnanswered) {
                          // ถ้ายังมีข้อที่ไม่ได้ตอบ โชว์ Alert แจ้งเตือน
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('แจ้งเตือน'),
                                  content: const Text(
                                    'กรุณาตอบให้ครบทุกข้อก่อนส่งคำตอบ',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ตกลง'),
                                    ),
                                  ],
                                ),
                          );
                          return; // หยุดไม่ให้ไปคำนวณคะแนน
                        }
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
                        _saveExamResult(score); // บันทึกผลสอบ
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
                      child: const Text(
                        'ส่งคำตอบ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Future<void> _saveExamResult(int score) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('🔐 ไม่พบ user, กำลังทำ anonymous login...');
        UserCredential userCredential =
            await FirebaseAuth.instance.signInAnonymously();
        user = userCredential.user;
        print('✅ Anonymous login สำเร็จ: ${user?.uid}');
      }
      if (user != null) {
        final percentage = (score / questions!.length * 100).round();

        await FirebaseFirestore.instance.collection('exam_results').add({
          'userId': user.uid,
          'score': score,
          'totalQuestions': questions!.length,
          'percentage': percentage,
          'wrongAnswer': wrongAnswer,
          'timeSpent': _formatTime(_seconds),
          'mode': widget.mode,
          'grade': widget.grade,
          'subject': widget.subject,
          'year': widget.year,
          'completedAt': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });
        print(
          '✅ บันทึกผลสอบสำเร็จ: $score/${questions!.length} ($percentage%)',
        );
      }
    } catch (e) {
      print('❌ เกิดข้อผิดพลาดในการบันทึก: $e');
    }
  }

  Widget buildQuestionItem(int index, Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${index + 1}. ${item['question']}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        if (item['image'] != null && item['image'].toString().isNotEmpty)
          Image.asset(
            item['image'],
            height: 250,
            errorBuilder: (_, __, ___) => const SizedBox(),
          ),

        const SizedBox(height: 8),

        Column(
          children:
              (item['choices'] as List).asMap().entries.map((entry) {
                final choiceIndex = entry.key;
                final choice = entry.value;
                return Row(
                  children: [
                    EasyRadio(
                      value: choice,
                      groupValue: item['selectedAnswer'],
                      onChanged: (value) {
                        setState(() {
                          item['selectedAnswer'] = value;
                          savedAnswers =
                              questions!
                                  .map((e) => e['selectedAnswer'])
                                  .toList();
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                    Expanded(child: Text("${choiceIndex + 1}. $choice")),
                  ],
                );
              }).toList(),
        ),

        const Divider(),
      ],
    );
  }
}
