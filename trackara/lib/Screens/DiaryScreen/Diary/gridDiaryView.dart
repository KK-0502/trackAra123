import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

class Griddiaryview extends StatelessWidget {
  const Griddiaryview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ValueListenableBuilder(
        valueListenable: diaryNotify,
        builder: (BuildContext ctx, List<DiaryModel> diaryModelList, Widget? child) {
          // If the list is empty, show a message.
          if (diaryModelList.isEmpty) {
            return Center(
              child: Text("No Data Found"),
            );
          }

          // Get the screen width to adjust the item size dynamically
          final screenWidth = MediaQuery.of(context).size.width;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DiaryModel diary = diaryModelList[index];

              return Container(
                width: screenWidth * 0.45, // Adjusting width dynamically to 45% of screen width
                margin: EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image widget with a fixed aspect ratio to avoid overflow
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: loadImage(diary.image),
                    ),
                    const SizedBox(height: 8),
                    // Date Text
                    Text(
                      diary.date,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    // Title Text
                    Text(
                      diary.titile,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: diaryModelList.length,
          );
        },
      ),
    );
  }

  Widget loadImage(String imagePath) {
    // Check if image path is asset, URL, or file and load accordingly
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity, // Make sure image fills the container
        height: 150, // Set a fixed height for the image
      );
    } else if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity, // Make sure image fills the container
        height: 150, // Set a fixed height for the image
      );
    } else {
      File imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        return Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: double.infinity, // Make sure image fills the container
          height: 150, // Set a fixed height for the image
        );
      } else {
        return Image.asset('assets/image/fav.png', fit: BoxFit.cover); // Fallback to default image if file not found
      }
    }
  }
}
