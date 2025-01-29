import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trackara/Memory/memoryEditingScreen.dart';
import 'package:trackara/Model/MemoryModel/memoryModel.dart';

class ImageDetailScreen extends StatefulWidget {
  final MemoryModel meory;
  final int index;

  const ImageDetailScreen({super.key, required this.meory, required this.index});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.meory.titleGet),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) {
                  return EditingScreen(index: widget.index, meory: widget.meory);
                },
              ));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          // Set the background image using BoxDecoration
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/memoy.jpg'), // Your background image here
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.meory.dataGet,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Adjust text color to stand out over the image
                  ),
                ),
                SizedBox(height: 20),
                // Display images in individual cards inside the grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3), // Number of images per row
                    itemCount: widget.meory.imageListGet.length, // Total images
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8), // Space between cards
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners for the card
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Make sure image follows card's rounded corners
                          child: Image.file(
                            File(widget.meory.imageListGet[index]), // Load image from file
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
