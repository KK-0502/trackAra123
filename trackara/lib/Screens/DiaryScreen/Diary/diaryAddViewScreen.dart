import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/DiaryViewScreen/dairyViewScreen.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/DiaryViewScreen/dairyViewScreenNew.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/editDairy.dart';

int totalDiary = 0; // Global variable to track total diary count

class ViewListDiary extends StatelessWidget {
  const ViewListDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: diaryNotify, // Listening for changes in the diary list
      builder: (BuildContext ctx, List<DiaryModel> diaryModelList, Widget? child) {
        // Update the total diary count whenever the list changes
        totalDiary = diaryModelList.length;

        // Display message when no diaries are available
        if (diaryModelList.isEmpty) {
          return Center(
            child: Text("No Diary, add your Diary"),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  DiaryModel diary = diaryModelList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                        return DiaryViewScreenNew(diary: diary, index: index);
                      }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF4000FF),
                          Color(0xFF00EEFF),
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            // Main content container
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: loadImage(diary.image),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        diary.date,
                                        style: TextStyle(
                                          fontFamily: "Mine",
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        diary.time,
                                        style: TextStyle(
                                          fontFamily: "Mine",
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        diary.titile,
                                        style: TextStyle(
                                          fontFamily: "Mine",
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        diary.subJect,
                                        style: TextStyle(
                                          fontFamily: "Mine",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Positioned favorite icons in the top-right corner
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Row(
                                children: [
  
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                                        return EditDairy(diary: diary, index: index);
                                      }));
                                    },
                                    child: Icon(Icons.edit_note_rounded),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () async {
                                      await deleteDiary(index); // Deleting the diary
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 30);
                },
                itemCount: diaryModelList.length,
              ),
            ),
          ],
        );
      },
    );
  }

  // Load image based on the path (Asset, Network, or File)
  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(imagePath, fit: BoxFit.cover);
    } else {
      File imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        return Image.file(imageFile, fit: BoxFit.cover);
      } else {
        return Image.asset('assets/image/fav.png'); // Fallback to default image if file not found
      }
    }
  }

}
