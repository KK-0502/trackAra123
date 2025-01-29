import 'package:flutter/material.dart';

class PrivacyAndPollicy extends StatelessWidget {
  const PrivacyAndPollicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center( // Center widget to center everything inside it
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Adjust width to 90% of screen width
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0), // Padding inside the card
                    child: Column(
                      children: const [
                        // Title of the Privacy Policy
                        Text(
                          "Privacy And Policy",
                          style: TextStyle(
                            fontFamily: "Mine", // Ensure this font is correctly defined
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        // Content of the Privacy Policy
                        Text(
                          "Trackara is a mobile app that helps you track habits, set life goals, and maintain a diary. "
                          "All data entered into the app, such as your habits, goals, and diary entries, is stored locally "
                          "on your device and not shared with any external servers or third parties. We do not collect or "
                          "transmit any personal data, and your information remains private and under your control. "
                          "Since Trackara operates offline, no data is stored on remote servers, ensuring that your data stays "
                          "secure on your device.\n\nBy using Trackara, you agree to the storage of your data on your device for "
                          "personal use. It's your Trackara.",
                          style: TextStyle(
                            fontFamily: "Mine", // Ensure this font is correctly defined
                            fontSize: 16,
                            height: 1.5, // Adjust line height for better readability
                          ),
                          textAlign: TextAlign.justify, // Justified text alignment
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
