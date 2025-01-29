import 'package:flutter/material.dart';
import 'package:trackara/Memory/memoryHomeScreen.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/dairyAddNew.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/diaryAddViewScreen.dart';
import 'package:trackara/Screens/DiaryScreen/Favourite/favDairyScreen.dart';

import 'package:trackara/Screens/DiaryScreen/Diary/dairyAddScreen.dart';

class DairyHome extends StatelessWidget {
  const DairyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Your DIAry",
          style: TextStyle(fontFamily: "Mine", fontSize: 21),
        ),
        actions: [
          
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return Memoryhomescreen();
              }));
            },
            icon: const Icon(
              Icons.photo_camera_back_outlined,
              color: Colors.blue,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return DiaryAddNewScreen();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00EEFF),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            // Wrap everything inside SingleChildScrollView
            child: Column(
              children: [
                // Search bar (assuming SearchBar widget is implemented somewhere)
                // SearchBar(
                //   backgroundColor: WidgetStatePropertyAll(Colors.white),
                //   hintText: "Search your DIAry",
                //   trailing: [
                //     IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                //     IconButton(
                //         onPressed: () {},
                //         icon: Icon(Icons.calendar_month_outlined)),
                //   ],
                // ),
                SizedBox(height: 20),
                // List view starts here
                Container(
                  height: MediaQuery.of(context)
                      .size
                      .height, // Fix the height of the inner ListView
                  child: ViewListDiary(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
