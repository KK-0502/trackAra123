import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Functions/db_doal.dart';
import 'package:trackara/Functions/db_functions.dart';
import 'package:trackara/Functions/db_memory.dart';
import 'package:trackara/Functions/db_quotes.dart';
import 'package:trackara/Screens/HomeScreen/diaryViewAll.dart';
import 'package:intl/intl.dart';
import 'package:trackara/Screens/HomeScreen/goalViewAll.dart';
import 'package:trackara/Screens/HomeScreen/menuBar.dart';
import 'package:trackara/Screens/HomeScreen/Quotes/percentage.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/gridDiaryView.dart';
import 'package:trackara/Screens/HomeScreen/habitScreen.dart';

String selectedDay = "";
int count = 0;
int comCount = 0;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<bool> selectedIndex = List.generate(20, (index) => false);
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDay = DateFormat('EEEE').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    getHabit();
    getGoal();
    getDiary();
    quotesget();
    getImage();
    // Get screen width and height for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),  // Responsive padding
          child: ListView(
            children: [
              TitleBar(),
              SizedBox(
                height: screenHeight * 0.02,  // Adjust space dynamically
              ),
              Text(
                "Today",
                style: TextStyle(
                  fontSize: screenWidth * 0.065, // Adjust text size based on screen width
                  fontFamily: "Mine",
                ),
              ),
              SizedboxWidget(),
              Column(
                children: [
                  Container(
                    child: DatePicker(
                      DateTime.now(),
                      height: 87,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Color(0xFF18E7E7),
                      dateTextStyle: TextStyle(
                        fontSize: screenWidth * 0.05, // Adjust font size based on screen width
                        fontWeight: FontWeight.w600,
                      ),
                      monthTextStyle: TextStyle(fontSize: screenWidth * 0.03), // Adjust month text size
                      dayTextStyle: TextStyle(fontSize: screenWidth * 0.03),  // Adjust day text size
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = date;
                          selectedDay = DateFormat('EEEE').format(date);
                        });
                      },
                    ),
                  ),
                ],
              ),
              //calendarFinished
              SizedboxWidget(),
              PercentageIndicator(),
              SizedboxWidget(),
              HabitScreem(),
              SizedboxWidget(),
              GoalViewAll(),
              SizedboxWidget(),
              DiaryViewAll(),
              Griddiaryview()
            ],
          ),
        ),
      ),
    );
  }
}
