import 'package:flutter/material.dart';
import 'package:trackara/Screens/DiaryScreen/Diary/editDairy.dart';
import 'package:trackara/Screens/DiaryScreen/Favourite/favDairyView.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Favourite DIAry",
          style: TextStyle(fontFamily: "Mine", color: Colors.red, fontSize: 21),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.red,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar (assuming SearchBar widget is implemented somewhere)
              SearchBar(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                hintText: "Search your Favourite DIAry",
                trailing: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.calendar_month_outlined)),
                ],
              ),
              SizedBox(height: 20),
              // List view starts here
              Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Fix the height of the inner ListView
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return FavDiaryView();
                        }));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 150,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFFFF001A), Color(0xFF00EEFF)]),
                            borderRadius: BorderRadius.circular(10)),
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
                                    child: Image.asset(
                                      'assets/image/batman.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "10/11/2024",
                                          style: TextStyle(
                                              fontFamily: "Mine", fontSize: 14),
                                        ),
                                        Text(
                                          "10:30pm",
                                          style: TextStyle(
                                              fontFamily: "Mine", fontSize: 14),
                                        ),
                                        Text(
                                          "THE MEMORY",
                                          style: TextStyle(
                                              fontFamily: "Mine", fontSize: 18),
                                        ),
                                        Text(
                                          "Today i’m very happy",
                                          style: TextStyle(
                                              fontFamily: "Mine", fontSize: 14),
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
                                    Icon(Icons.favorite_border_outlined),
                                    SizedBox(width: 5),
                                    Icon(Icons.edit_note_rounded),
                                    SizedBox(width: 5),
                                    Icon(Icons.delete),
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
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
