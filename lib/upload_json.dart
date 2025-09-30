import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

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
                onPressed: () async {
                  await uploadFromAsset();
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
  try {
    const year = 2565;
    const grade = 'M3';
    const subject = 'Science';

    final db = FirebaseFirestore.instance;
    final text = await rootBundle.loadString('M32565/M3Science2565.json');
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
  } catch (e) {
    print('Error during anonymous sign-in: $e');
    return;
  }
}
