import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                          "Report",
                          style: TextStyle(
                            fontFamily: "Mine", // Ensure this font is correctly defined
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        // Content of the Privacy Policy
                        Text(
                          "For any questions or concerns, please contact us at."
                          
                          ,
                          style: TextStyle(
                            fontFamily: "Mine", // Ensure this font is correctly defined
                            fontSize: 16,
                            height: 1.5, // Adjust line height for better readability
                          ),
                          textAlign: TextAlign.justify, // Justified text alignment
                        ),
                        SizedBox(height: 15),
                        // Content of the Privacy Policy
                        Text(
                          
                          "trackara133@gmail.com"
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