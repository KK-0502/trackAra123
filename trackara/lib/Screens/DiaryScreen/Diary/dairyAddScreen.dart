import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

class AddDairy extends StatefulWidget {
  const AddDairy({super.key});

  @override
  State<AddDairy> createState() => _AddDairyState();
}

class _AddDairyState extends State<AddDairy> {
  final formateDate=DateFormat("dd-MM-yyyy").format(DateTime.now());
  final formateTime=DateFormat("hh:mm a").format(DateTime.now());
  final dateController=TextEditingController();
  final titleController=TextEditingController();
  final subjectController=TextEditingController();
  final timeController=TextEditingController();
  final diaryController=TextEditingController();
  
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
  @override
  Widget build(BuildContext context) {
    setState(() {
      dateController.text=formateDate.toString();
      timeController.text=formateTime.toString();
    });
    final screenWdith = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          "Add Your DIAry",
          style: TextStyle(fontFamily: "Mine", fontSize: 21),
        ),
        actions: [IconButton(onPressed: () {
          addValue();
          Navigator.of(context).pop();
        }, icon: Icon(Icons.save))],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWdith,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 175,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  
                                  controller: dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Date",
                                      hintStyle: TextStyle(
                                          fontFamily: "Mine", fontSize: 16)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Title",
                                      hintStyle: TextStyle(
                                          fontFamily: "Mine", fontSize: 16)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: subjectController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Subject",
                                      hintStyle: TextStyle(
                                          fontFamily: "Mine", fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: getImage,
                          child: Container(
                            width: screenWdith * 0.3,
                            height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: image != null
                                ? Image.file(
                                    image!.absolute,
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Icon(Icons.camera),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "About your DIAry ",
                style: TextStyle(fontFamily: "Mine", fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: screenWdith * 0.5,
                height: 50,
                child: TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter your time",
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: diaryController,
                maxLines: 50,
                decoration: InputDecoration(
                  hintText: "Text Your Diary",
                  border: OutlineInputBorder()
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
  void addValue(){
    final date=dateController.text.trim();
    final titile=titleController.text.trim();
    final subJect=subjectController.text.trim();
    final image=imagePath!;
    final time=timeController.text.trim();
    final text=diaryController.text.trim();

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
