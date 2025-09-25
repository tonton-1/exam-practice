import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadFromAsset() async {
  const year = 2567;
  const grade = 'P6';
  const subject = 'English';

  final db = FirebaseFirestore.instance;
  final text = await rootBundle.loadString('assets/P6English2567.json');
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
}
