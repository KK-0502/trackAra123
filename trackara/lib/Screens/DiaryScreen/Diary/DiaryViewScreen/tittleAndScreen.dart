import 'package:flutter/material.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

class Tittleandscreen extends StatefulWidget {
  final DiaryModel diary;
  const Tittleandscreen({super.key, required this.diary});

  @override
  State<Tittleandscreen> createState() => _TittleandscreenState();
}

class _TittleandscreenState extends State<Tittleandscreen> {
  @override
  Widget build(BuildContext context) {
    String date = widget.diary.date;
    String time = widget.diary.time;
    String title = widget.diary.titile;
    String subject = widget.diary.subJect;
    String text = widget.diary.text;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(title, style: TextStyle(fontSize: screenWidth * 0.05)),
        ),
        SizedBox(height: screenHeight * 0.02), // Space between sections

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(subject, style: TextStyle(fontSize: screenWidth * 0.05)),
        ),
        SizedBox(height: screenHeight * 0.02),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(date, style: TextStyle(fontSize: screenWidth * 0.05)),
        ),
        SizedBox(height: screenHeight * 0.02),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(time, style: TextStyle(fontSize: screenWidth * 0.05)),
        ),
        SizedBox(height: screenHeight * 0.02),

        // Second Card
        SizedBox(
          width: screenWidth, // Full width of the screen
          height: screenHeight * 0.4, // 40% of screen height
          child: Card(
            color: Colors.black,
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.05),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
