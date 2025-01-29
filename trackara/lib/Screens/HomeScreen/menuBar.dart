import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart'; // Import the database functions

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello,",
          style: TextStyle(
            fontFamily: "Mine",
            fontSize: 28,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        // Listen to the userProfileNotifier to update the name dynamically
        ValueListenableBuilder<UserProfileModel?>(
          valueListenable: userProfileNotifier,
          builder: (BuildContext ctx, UserProfileModel? userProfile, Widget? child) {
            if (userProfile == null) {
              return Text(
                'Guest',
                style: TextStyle(
                    fontFamily: "Mine",
                    fontSize: 28,
                    color: Color(0xFF10A0AA)),
              );
            } else {
              return Text(
                userProfile.name, // Display the name from the user profile
                style: TextStyle(
                    fontFamily: "Mine",
                    fontSize: 28,
                    color: Color(0xFF10A0AA)),
              );
            }
          },
        ),
      ],
    );
  }
}
