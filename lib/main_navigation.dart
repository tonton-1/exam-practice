import 'package:flutter/material.dart';
import 'home.dart';
import 'profile_screen.dart';
import 'history_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    HistoryScreen() /*ProfileScreen()*/,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color.fromARGB(255, 86, 179, 191),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            activeIcon: Icon(
              Iconsax.home,
              color: Color.fromARGB(255, 86, 179, 191),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.chart_2),
            activeIcon: Icon(
              Iconsax.chart_2,
              color: Color.fromARGB(255, 86, 179, 191),
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Iconsax.profile_circle),
          //   activeIcon: Icon(
          //     Iconsax.profile_circle,
          //     color: Color.fromARGB(255, 86, 179, 191),
          //   ),
          //   label: '',
          // ),
        ],
      ),
    );
  }
}
