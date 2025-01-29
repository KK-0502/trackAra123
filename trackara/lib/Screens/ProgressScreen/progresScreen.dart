import 'package:flutter/material.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/habitAddValue.dart'; // Assuming this is where `totalHabits` and `completedHabits` are declared
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/diaryAddViewScreen.dart'; // Ensure this widget exists or use a SizedBox directly

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    updateProgress(); // Update progress on screen load
  }

  // This function updates the progress based on completed and total habits
  void updateProgress() {
    setState(() {
      // Calculate the progress dynamically based on total and completed habits
      progress = totalHabits > 0 ? (completedHabits / totalHabits) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Progress",
          style: TextStyle(
            fontFamily: "Mine",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Habit Progress Section
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // Adjust card width as per need
                    height: 300,
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Center content inside the card
                          children: [
                            Text(
                              "Habit Progress",
                              style: TextStyle(
                                fontFamily: "Mine",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20), // A simple SizedBox for spacing
                            LinearProgressIndicator(
                              value: progress, // Set the progress dynamically
                              color: Color(0xFF00F7FF),
                              minHeight: 13,
                              backgroundColor: Color(0xFFE7E7E7),
                            ),
                            SizedBox(height: 20), // Spacing below progress bar
                            Text(
                              "${(progress * 100).toStringAsFixed(0)}% Completed",
                              style: TextStyle(
                                fontFamily: "Mine",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Total Diary Count Section
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Adjust card width as per need
                height: 300,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center content inside the card
                      children: [
                        Text(
                          "Total Diaries",
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20), // A simple SizedBox for spacing
                        Text(
                          "$totalDiary", // Displaying the total diary count
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(height: 20), // Spacing below the count
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
