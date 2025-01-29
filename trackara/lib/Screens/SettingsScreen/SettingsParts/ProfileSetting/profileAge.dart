import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';

class ProfileAge extends StatelessWidget {
  ProfileAge({super.key});
  final ageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Card(
        color: Colors.black,
        elevation: 10,
        child: ValueListenableBuilder<UserProfileModel?>(
          valueListenable: userProfileNotifier,  // Ensure this is properly initialized elsewhere
          builder: (BuildContext ctx, UserProfileModel? userList, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userList?.age.toString() ??"0", // Safe check for null
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Mine",
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateAge(context);
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void updateAge(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Update Your Age"),
          content: TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              hintText: "Age",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // Ensure only numeric input
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await updateDb(context); // Save the updated age to the database
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateDb(BuildContext context) async {
    final newAge = int.tryParse(ageController.text.trim());

    if (newAge != null && newAge > 0) { // Check if age is valid
      final userProfile = userProfileNotifier.value;

      if (userProfile != null) {
        final updatedProfile = UserProfileModel(
          name: userProfile.name,
          email: userProfile.email,
          age: newAge,
          hobbie: userProfile.hobbie,
          image: userProfile.image,
        );

        // Update the profile in the database
        await editUserProfile(updatedProfile);

        // Update the ValueNotifier to reflect the changes in the UI
        userProfileNotifier.value = updatedProfile;
      }
    } else {
      // Optionally, show an error message if the age is invalid
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid age."),
      ));
    }
  }
}
