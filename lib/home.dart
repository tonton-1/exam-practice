import 'package:flutter/material.dart';
import 'education_level_selector_onet.dart';
import 'subject_selector.dart';
import 'year_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            /* เรียงตาม ระดับชั้น > วิชา > ปี  
            พอกดเลือกปีแล้วมีโมหดให้เลืก 1.ธรรมดา 2.จับเวลา



            ของ ม3 ป6 เอา แค่ปี 67 66 
            ม6 เอาแค่ปี 64 63 
            
            */
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Educationlevel(),
                  ),
                );
              },
              child: Text('ข้อสอบ Onet'),
            ),
          ],
        ),
      ),
    );
  }
}
