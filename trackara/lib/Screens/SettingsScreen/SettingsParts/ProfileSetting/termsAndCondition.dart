import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

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
                      children: [
                        // Title of the Privacy Policy
                        Text(
                          "Terms And Condition",
                          style: TextStyle(
                            fontFamily: "Mine", // Ensure this font is correctly defined
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        // Content of the Privacy Policy
                        Text(
                          "By using Trackara, you agree to comply with these Terms and Conditions. Trackara is an offline mobile app that helps you track habits, set life goals, and maintain a diary. All data entered into the app (such as habits, goals, and diary entries) is stored locally on your device and is not shared with any external servers or third parties.\n\n"
                          "You are responsible for securing your device to protect your data. You can edit, delete, or back up your data at any time. The app does not require an internet connection and works offline, ensuring that your data remains private.\n\n"
                          "Trackara is provided 'as is,' and we do not guarantee that the app will meet your specific needs or be error-free. By using Trackara, you agree not to hold us liable for any issues or damages related to its use.\n\n"
                          ,
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
