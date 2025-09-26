import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Upload JSON')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  uploadFromAsset();
                },
                child: const Text('Upload JSON to Firestore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> uploadFromAsset() async {
  const year = 2567;
  const grade = 'P6';
  const subject = 'English';

  final db = FirebaseFirestore.instance;
  final text = await rootBundle.loadString('P62567/P6English2567.json');
  print('✅ โหลดไฟล์สำเร็จ! ขนาด: ${text.length} characters');
  final List<dynamic> items = json.decode(text);

  final base = db
      .collection('grades')
      .doc(grade) // P6
      .collection('subjects')
      .doc(subject) // English
      .collection('years')
      .doc('$year') // 2567
      .collection('questions');

  final batch = db.batch();
  for (final q in items) {
    final doc = base.doc();
    batch.set(doc, {
      'question': q['question'] ?? '',
      'choices': q['choices'] ?? [],
      'correct_answer': q['correct_answer'],
      'image': q['image'],
      'year': year,
      'grade': grade,
      'subject': subject,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  await batch.commit();
  print('Upload complete! $year $grade $subject ${items.length} questions');
}
