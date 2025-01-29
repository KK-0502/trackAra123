import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackara/Functions/db_memory.dart';
import 'package:trackara/Memory/memoryHomeScreen.dart';
import 'package:trackara/Model/MemoryModel/memoryModel.dart';

class EditingScreen extends StatefulWidget {
  final MemoryModel meory; // Memory object to edit
  final int index; // Index of the memory being edited

  const EditingScreen({super.key, required this.meory, required this.index});

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = []; // List to hold XFile objects

  final textController = TextEditingController();
  final titleGetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with the data from the existing memory
    textController.text = widget.meory.dataGet;
    titleGetController.text = widget.meory.titleGet;
    
    // Initialize imageFileList with the existing images if any
    if (widget.meory.imageListGet.isNotEmpty) {
      imageFileList = widget.meory.imageListGet.map((imagePath) {
        return XFile(imagePath); // Convert image path to XFile
      }).toList();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextFormField(
          textAlign: TextAlign.center,
          controller: titleGetController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: "Title",
            hintStyle: TextStyle(fontSize: 24, color: Colors.black),
          ),
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
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: selectedImages, // Pick new images
                          icon: Icon(Icons.photo_album, color: Colors.white),
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
                              await sendData(); // Save the data and navigate back
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx) {
                                  return Memoryhomescreen(); // Navigate back to home screen
                                }),
                              );
                            }
                          },
                          icon: Icon(Icons.telegram_outlined, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
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

  // Function to pick multiple images
  void selectedImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages); // Add selected images to the list
      });
    }
  }

  // Function to save the data
  Future<void> sendData() async {
    final titleGet = titleGetController.text.trim();
    final text = textController.text.trim();
    final List<String> imageList = imageFileList.map((e) => e.path).toList(); // Convert XFile to String (path)
    
    final newGetData = MemoryModel(
      titleGet: titleGet,
      dataGet: text,
      imageListGet: imageList,
    );
    
    await updateMemory(widget.index, newGetData); // Update the memory

    // Optionally, clear the list of images after sending
    setState(() {
      imageFileList.clear();
    });
  }
}
