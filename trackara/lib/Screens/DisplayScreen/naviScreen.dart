import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trackara/Screens/HomeScreen/homeScreen.dart';
import 'package:trackara/Screens/ActivityScreen/activity.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/dairyHome.dart';
import 'package:trackara/Screens/ProgressScreen/progresScreen.dart';
import 'package:trackara/Screens/SettingsScreen/settingScreen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final _pages = [
    Homescreen(),
    ActivityScreen(),
    DairyHome(),
    ProgressScreen(),  
    Settings(),
  ];

  int indexnum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color:Color(0xFF000080),
        animationDuration: Duration(milliseconds: 500),
        items: [
       Icon(Icons.home_outlined,color: Colors.white,),
       Icon(Icons.run_circle_outlined,color: Colors.white),
       Icon(Icons.book_outlined,color: Colors.white),
       Icon(Icons.pie_chart_outline_outlined,color: Colors.white),
       Icon(Icons.person_outline_outlined,color: Colors.white),
        ],
       // currentIndex: indexnum,
        onTap: (int index) {
          setState(() {
            indexnum = index;
          });
        },
      ),
      body: _pages[indexnum],
    );
  }
}
