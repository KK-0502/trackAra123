import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

class CardImagePortion extends StatefulWidget {
  final DiaryModel adddiary;
  const CardImagePortion({super.key, required this.adddiary});

  @override
  State<CardImagePortion> createState() => _CardImagePortionState();
}

class _CardImagePortionState extends State<CardImagePortion> {
  @override
  Widget build(BuildContext context) {
    String image = widget.adddiary.image;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth, // Full width of the screen
      height: screenHeight * 0.3, // 30% of screen height
      child: Card(
        color: Colors.white,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
          child: loadImage(image),
        ),
      ),
    );
  }

  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
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
}
