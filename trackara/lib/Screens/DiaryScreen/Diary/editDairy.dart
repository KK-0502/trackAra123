import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trackara/Functions/db_diary.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

class EditDairy extends StatefulWidget {
  final DiaryModel diary;
  final int index;
  const EditDairy({super.key, required this.diary, required this.index});

  @override
  State<EditDairy> createState() => _EditDairyState();
}

class _EditDairyState extends State<EditDairy> {
  final formateDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final formateTime = DateFormat("hh:mm a").format(DateTime.now());
  final dateController = TextEditingController();
  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final timeController = TextEditingController();
  final textController = TextEditingController();

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
  void initState() {
    super.initState();
    // Set the initial values from the diary passed to the screen
    titleController.text = widget.diary.titile;
    subjectController.text = widget.diary.subJect;
    textController.text = widget.diary.text;
    imagePath = widget.diary.image;
    dateController.text = formateDate.toString();
    timeController.text = formateTime.toString();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Edit Your Diary",
          style: TextStyle(fontFamily: "Mine", fontSize: 21),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                updateDiaryValue();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: getImage,
                            child: Container(
                              width: screenWidth * 0.3,
                              height: 130,
                              child: image != null
                                  ? Image.file(
                                      image!.absolute,
                                      fit: BoxFit.cover,
                                    )
                                  : loadImage(imagePath!),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 175,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: dateController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Date",
                                      hintStyle: TextStyle(
                                          fontFamily: "Mine", fontSize: 16),
                                    ),
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
                                          fontFamily: "Mine", fontSize: 16),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Your Title";
                                      } else {
                                        return null;
                                      }
                                    },
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
                                          fontFamily: "Mine", fontSize: 16),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Your Subject";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "About your Diary",
                    style: TextStyle(fontFamily: "Mine", fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: screenWidth * 0.5,
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
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
                    controller: textController,
                    maxLines: 50,
                    decoration: InputDecoration(
                      hintText: "Text Your Diary",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Diary Text";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
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

  Future<void> updateDiaryValue() async {
    final date = dateController.text.trim();
    final title = titleController.text.trim();
    final subject = subjectController.text.trim();
    final image = imagePath!;
    final time = timeController.text.trim();
    final text = textController.text.trim();

    final updatedValue = DiaryModel(
      date: date,
      titile: title,
      subJect: subject,
      image: image,
      time: time,
      text: text,
    );
    await updateDairy(widget.index, updatedValue);
    Navigator.of(context).pop();
  }
}
