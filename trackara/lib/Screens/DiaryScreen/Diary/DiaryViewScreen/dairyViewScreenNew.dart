import 'package:flutter/material.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/DiaryViewScreen/cardImage.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/DiaryViewScreen/tittleAndScreen.dart';

class DiaryViewScreenNew extends StatefulWidget {
  final DiaryModel diary;
  final int index;
  const DiaryViewScreenNew({super.key,required this.diary,required this.index});

  @override
  State<DiaryViewScreenNew> createState() => _DiaryViewScreenNewState();
}

class _DiaryViewScreenNewState extends State<DiaryViewScreenNew> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Card
            CardImagePortion(adddiary: widget.diary,),
            SizedBox(height: screenHeight * 0.02), // Space between cards
            Tittleandscreen(diary: widget.diary,)
          ],
        ),
      ),
    );
  }
}
