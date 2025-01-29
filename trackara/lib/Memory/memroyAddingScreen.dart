import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackara/Functions/db_memory.dart';
import 'package:trackara/Memory/memoryHomeScreen.dart';
import 'package:trackara/Model/MemoryModel/memoryModel.dart';

class AddingScreen extends StatefulWidget {
  const AddingScreen({super.key});

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];  // List to hold XFile objects

  // Function to pick multiple images
  void selectedImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
  }

  final textController = TextEditingController();
  final titleGetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          textAlign: TextAlign.justify,
          controller: titleGetController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: "Title",
            hintStyle: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter Title";
            } else {
              return null;
            }
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/memory.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: imageFileList.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(imageFileList[index].path),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: "Enter text",
                    labelStyle: TextStyle(color: Colors.white), // Text color for label
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min, // Ensures the icons don't overflow
                      children: [
                        IconButton(
                          onPressed: () {
                            selectedImages();  // Allow the user to pick images
                          },
                          icon: Icon(
                            Icons.photo_album,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final titleGet = titleGetController.text.trim();
                            final text = textController.text.trim();

                            // Check if the title is empty
                            if (titleGet.isEmpty) {
                              // Show a Snackbar if title is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Title cannot be empty")),
                              );
                              return; // Exit the function early if title is empty
                            }

                            // Check if images are empty
                            if (imageFileList.isEmpty) {
                              // Show a Snackbar if no images are selected
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Please add at least one image")),
                              );
                              return; // Exit the function early if no images are selected
                            }

                            if (_formKey.currentState!.validate()) {
                              // Proceed to save the data if everything is valid
                              await sendData();  // Save data and navigate
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return Memoryhomescreen();  // Navigate to home screen
                                  },
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.telegram_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  style: TextStyle(color: Colors.white), // Ensure text color is visible
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Description";
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
    );
  }

  // Function to save the data
  Future<void> sendData() async {
    final titleGet = titleGetController.text.trim();
    final text = textController.text.trim();

    // Convert XFile to String (the path)
    final List<String> imageList = imageFileList.map((e) => e.path).toList(); // Convert XFile to String (path)
    
    final newGetData = MemoryModel(titleGet: titleGet, dataGet: text, imageListGet: imageList);

    // Add the image data to your database or storage
    await addImage(newGetData);  // Assuming addImage is saving the data

    // Optionally, you can clear the list of images after sending
    setState(() {
      imageFileList.clear();
    });
  }
}
