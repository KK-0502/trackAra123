import 'package:flutter/material.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/goalAddValue.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/goaladdingNew.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/habitAddValue.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/createGoal.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/createTodayHabit.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // List of habit names
  List<String> habits = [
    "Meditating",
    "Read Philosophy",
    "Journaling",
    "Exercise"
  ];

  // List to track whether each habit is checked (true/false)
  List<bool> isChecked = [
    false,
    false,
    false,
    false
  ]; // List<bool> to track checkbox state for each habit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // First blue container with checkboxes
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today Habit",
                            style: TextStyle(fontFamily: "Mine", fontSize: 21),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: HabitList(),
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.green,
                                  Color(0xFF000080)
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return CreateHabit();
                                      }));
                                    },
                                    child: Text(
                                      "CREATE NEW HABIT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Mine",
                                        fontSize: 14,
                                      ),
                                    ))),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              // Second blue container (unchanged)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Your Goal",
                                style: TextStyle(
                                    fontFamily: "Mine", fontSize: 21)),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              child: ListGoal(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFFf5e6a4),
                                    Color(0xFF99763d),
                                  ]),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                          return GoalAddingScreen();
                                        }));
                                      },
                                      child: Text(
                                        "CREATE NEW GOAL",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Mine",
                                          fontSize: 14,
                                        ),
                                      ))),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
