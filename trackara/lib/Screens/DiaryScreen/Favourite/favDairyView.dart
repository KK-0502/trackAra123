import 'package:flutter/material.dart';

class FavDiaryView extends StatelessWidget {
  const FavDiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.red,
        ),
        title: Text(
          "Your Favourite Diary",
          style: TextStyle(
            fontFamily: "Mine",
            color: Colors.red,
            fontSize: screenWidth * 0.06, // Responsive font size
          ),
        ),
      ),
      // Set the Scaffold background color to transparent to let the image show
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/fav.png"),
            fit: BoxFit.cover, // Ensure the background covers the entire screen
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container with image
                  Container(
                    width: screenWidth, // Make it full width
                    height: screenHeight *
                        0.25, // Use a percentage of screen height for responsiveness
                    color: Colors.green,
                    child: Image.asset(
                      "assets/image/fav2.jpg",
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                  SizedBox(height: 10),
                  // Date Text with responsive font size
                  Text(
                    "10/11/2024",
                    style: TextStyle(
                        fontFamily: "Mine",
                        fontSize: screenWidth *
                            0.04, // Adjust font size for responsiveness
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  // Time Text with responsive font size
                  Text(
                    "10:30pm",
                    style: TextStyle(
                        fontFamily: "Mine",
                        fontSize: screenWidth * 0.04,
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  // Title "THE MEMORY" with responsive font size
                  Text(
                    "THE MEMORY",
                    style: TextStyle(
                      fontFamily: "Mine",
                      fontSize: screenWidth * 0.06, // Adjust font size

                      color: Colors.yellowAccent,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Short Description Text with responsive font size
                  Text(
                    "Today I’m very happy",
                    style: TextStyle(
                        fontFamily: "Mine",
                        fontSize: screenWidth * 0.04,
                        color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  // Long Description Text with responsive font size
                  Text(
                    "Hello everyone, this app was developed by Krishnakumar Kp. "
                    "This is my first project in the Brocamp batch. First of all, I’m a Flutter developer. "
                    "I completed my week 6, the first full domain week, and the basic description of this app: "
                    "It’s like a habit tracker, with an additional feature, a diary. You can use both activities in one app for your time management. "
                    "In the future, I will add more features. Stay tuned for that!",
                    style: TextStyle(
                        fontFamily: "Mine",
                        fontSize: screenWidth *
                            0.04, // Adjust font size for better readability on different screen sizes
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
