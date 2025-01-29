import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_memory.dart';
import 'package:trackara/Memory/memroyAddingScreen.dart';
import 'package:trackara/Memory/meoryViewScreen.dart';

import 'package:trackara/Model/MemoryModel/memoryModel.dart';

class Memoryhomescreen extends StatelessWidget {
  const Memoryhomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Memory"),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          // Navigate to AddingScreen when the floating button is pressed
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) {
              return AddingScreen(); // Ensure AddingScreen is imported correctly
            }),
          );
        },
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<MemoryModel>>(
          valueListenable: memoryNotify,
          builder: (BuildContext ctx, List<MemoryModel> imageList, Widget? child) {
            if (imageList.isEmpty) {
              return Center(child: Text("No Memories available."));
            }

            return ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (ctx, index) {
                MemoryModel image = imageList[index];
                return GestureDetector(
                  onTap: () {
                    // On item tap, navigate to a detail or edit screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ImageDetailScreen(meory: image, index: index);
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 75,
                    child: Card(
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            image.titleGet,
                            style: TextStyle(
                              fontFamily: "Mine", 
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                            deleteMemory(index);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
