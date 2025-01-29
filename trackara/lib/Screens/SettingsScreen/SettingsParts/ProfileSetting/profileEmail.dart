import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';

class ProfileEmail extends StatelessWidget {
  ProfileEmail({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Card(
        color: Colors.black,
        elevation: 10,
        child: ValueListenableBuilder<UserProfileModel?>(
          valueListenable: userProfileNotifier,
          builder: (BuildContext ctx, UserProfileModel? userList, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userList?.email ?? "No Email", // Safe check for null
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Mine",
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateEmail(ctx);
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

  // Show dialog to update email
  void updateEmail(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Update Your Email"),
          content: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
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
                final isValid = validateEmail(emailController.text.trim());
                if (isValid) {
                  await updateDb(context); // Save the updated email to the database
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter a valid email."),
                    ),
                  );
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Validate the email format using a regular expression
  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Update the database with the new email
  Future<void> updateDb(BuildContext context) async {
    final newEmail = emailController.text.trim();

    // If the email is not empty, update the profile
    if (newEmail.isNotEmpty) {
      // Fetch the existing profile from the ValueNotifier
      final userProfile = userProfileNotifier.value;

      if (userProfile != null) {
        // Create a new UserProfileModel with the updated email
        final updatedProfile = UserProfileModel(
          name: userProfile.name,
          email: newEmail,
          age: userProfile.age,
          hobbie: userProfile.hobbie,
          image: userProfile.image,
        );

        // Call the function to update the user profile in the database
        await editUserProfile(updatedProfile);

        // After updating the database, we also need to update the ValueNotifier
        userProfileNotifier.value = updatedProfile; // This updates the UI
      }
    }
  }
}
