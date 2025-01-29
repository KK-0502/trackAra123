import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';

class DiaryAddNewScreen extends StatefulWidget {
  const DiaryAddNewScreen({super.key});

  @override
  State<DiaryAddNewScreen> createState() => _DiaryAddNewScreenState();
}

class _DiaryAddNewScreenState extends State<DiaryAddNewScreen> {
  final formateDate = DateFormat("dd-MMM-yyyy").format(DateTime.now());
  final formateTime = DateFormat("hh:mm a").format(DateTime.now());
  final dateController = TextEditingController();
  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final timeController = TextEditingController();
  final diaryController = TextEditingController();
  File? image;
  final picker = ImagePicker();
  String? imagePath;

  Future<void> getImage() async {
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickImage != null) {
        image = File(pickImage.path);
        imagePath = image!.path;
        print(imagePath);
      } else {
        print("no image selected");
      }
    });
  }
  final _gobalKey=GlobalKey<FormState>();
  final _formKey=GlobalKey<FormState>();
  final _textKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set date and time fields
    setState(() {
      dateController.text = formateDate.toString();
      timeController.text = formateTime.toString();
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Your Daily Diary",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        actions: [
          TextButton(
              onPressed: () {
                if(_gobalKey.currentState!.validate()&&_formKey.currentState!.validate()
                && _textKey.currentState!.validate()
                ){
                  addValue();
                Navigator.of(context).pop();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      // Body part
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Image Selection Section
                Form(
                  key: _gobalKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:
                            screenWidth * 0.65, // Flexible width for title input
                        child: TextFormField(
                          
                          style: TextStyle(color: Colors.white),
                          controller: titleController,
                          
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                                fontFamily: "Mine",
                                fontSize:
                                    screenWidth * 0.08, // Responsive font size
                                color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Enter Titile";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        width: screenWidth *
                            0.15, // Responsive width for image button
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: image != null
                            ? Image.file(
                                image!.absolute,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: IconButton(
                                  onPressed: getImage,
                                  icon: Icon(Icons.add_photo_alternate_outlined),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Space between sections

                // Date and Time Section
                Row(
                  children: [
                    SizedBox(
                      width:
                          screenWidth * 0.4, // Responsive width for date input
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: "Date",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width:
                          screenWidth * 0.4, // Responsive width for time input
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: "Time",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // Space between sections

                // Subject Input Section
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: subjectController,
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                            fontFamily: "Mine",
                            fontSize: screenWidth * 0.05, // Responsive font size
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLength: 30,
                        validator: (value){
                                  if(value==null||value.isEmpty){
                                    return "Enter Disccription";
                                  }else{
                                    return null;
                                  }
                                },
                      ),
                    ],
                  ),
                ),
                SizedboxWidget(),
                Divider(color: Color(0xFFf5e6a4)),
                SizedBox(height: screenHeight * 0.02), // Space between sections

                // Diary Text Input Section
                SizedBox(
                  width: screenWidth,
                  height:
                      screenHeight * 0.5, // Responsive height for diary input
                  child: Form(
                    key: _textKey,
                    child: Card(
                      color: Colors.black,
                      shadowColor: Color(0xFFf5e6a4),
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: diaryController,
                        style: TextStyle(color:Colors.white),
                        maxLines: 50,
                        decoration: InputDecoration(
                          hintText: "Write Your Diary",
                          hintStyle: TextStyle(
                            fontFamily: "Mine",
                            fontSize: screenWidth * 0.04, // Responsive font size
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value){
                                    if(value==null||value.isEmpty){
                                      return "Enter Your Diary";
                                    }else{
                                      return null;
                                    }
                                  },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addValue() {
    final date = dateController.text.trim();
    final titile = titleController.text.trim();
    final subJect = subjectController.text.trim();
    final image = imagePath!;
    final time = timeController.text.trim();
    final text = diaryController.text.trim();

final newdiaryValue = DiaryModel(
        date: date,
        titile: titile,
        subJect: subJect,
        image: image,
        time: time,
        text: text);
    addDiary(newdiaryValue);
  }
}
