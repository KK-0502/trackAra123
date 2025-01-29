import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PercentageIndicator extends StatefulWidget {
  const PercentageIndicator({super.key});

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
  final picker = ImagePicker();
  String? imagePath;
  ValueNotifier<String?> imageNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load the saved image when the app starts
  }

  // Load the image path from shared preferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('imagePath') ??
          ''; // Default to empty string if no path is found
      imageNotifier.value = imagePath; // Notify listeners about the image path
    });
  }

  // Save the image path in shared preferences
  Future<void> _saveImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', path); // Save the image path
    imageNotifier.value =
        path; // Update the ValueNotifier with the new image path
  }

  // Pick image from gallery
  Future<void> getImage() async {
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        imagePath = pickImage.path;
      });
      _saveImage(imagePath!); // Save the new image path
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ValueListenableBuilder<String?>(
          valueListenable: imageNotifier, // Listen to the imageNotifier
          builder: (BuildContext ctx, String? imagePath, Widget? child) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: imagePath != null && imagePath.isNotEmpty
                  ? Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/image/habit.jpg',
                      fit: BoxFit.cover,
                    ),
            );
          },
        ),
        Positioned(
          top: -8,
          right: -8,
          child: IconButton(
            onPressed: () {
              addQuotes(context);
              print("Button Pressed");
            },
            icon: Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Show dialog to add a new image (quote)
  void addQuotes(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          title: Center(
            child: Text("Add Your Quotes"),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                getImage();
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
