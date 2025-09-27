import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      imagePath: 'assets/onboardingscreenimage/1.png',
      title: "ฝึกทำข้อสอบ O-NET ได้ง่ายๆ",
      subtitle: "",
      description: "ติว O-NET ได้ทุกวัน",
      color: Colors.blue,
    ),
    OnboardingData(
      imagePath: 'assets/onboardingscreenimage/2.png',
      title: "ข้อสอบครบทุกระดับชั้น",
      subtitle: "",
      description:
          "ครบทุกวิชาหลัก ไทย อังกฤษ คณิตศาสตร์\nวิทยาศาสตร์ สังคมศึกษา",
      color: Colors.green,
    ),
    OnboardingData(
      imagePath: 'assets/onboardingscreenimage/3.png',
      title: "เลือกโหมดที่เหมาะกับคุณ",
      subtitle: "",
      description: "โหมดปกติสำหรับฝึกฝน\nโหมดจับเวลาเสมือนสอบจริง",
      color: Colors.orange,
    ),
    OnboardingData(
      imagePath: 'assets/onboardingscreenimage/4.png',
      title: "ติดตามความก้าวหน้า",
      subtitle: "",
      description: "ดูคะแนน ประวัติการทำข้อสอบ\nและวิเคราะห์จุดที่ต้องปรับปรุง",
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          spacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index),
              ),
            ),

            SizedBox(height: 30),

            // Bottom Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  // Previous Button
                  // if (_currentPage > 0)
                  //   Expanded(
                  //     child: OutlinedButton(
                  //       onPressed: () {
                  //         _pageController.previousPage(
                  //           duration: Duration(milliseconds: 300),
                  //           curve: Curves.easeInOut,
                  //         );
                  //       },
                  //       style: OutlinedButton.styleFrom(
                  //         padding: EdgeInsets.symmetric(vertical: 15),
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //       ),
                  //       child: Text('ก่อนหน้า', style: TextStyle(fontSize: 16)),
                  //     ),
                  //   ),

                  // Next/Start Button
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        _goToLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 28, 29, 29),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'เริ่มต้นใช้งาน',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            TextButton(
              onPressed: () => _goToLogin(),
              child: Text(
                'ข้าม',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Image.asset(
            data.imagePath,
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 40),

          // Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12),

          // Subtitle
          if (data.subtitle.isNotEmpty) ...[
            Text(
              data.subtitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: data.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
          ],

          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color:
            _currentPage == index
                ? const Color.fromARGB(255, 32, 32, 32)
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

class OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String description;
  final Color color;

  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.color,
  });
}
