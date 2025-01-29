import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';

class Profilename extends StatelessWidget {
  Profilename({super.key});
  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // To manage form validation
  // final _formKey=GlobalKey<FormState>();
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
                  userList?.name ?? "No Name", // Safe check for null
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Mine",
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateName(ctx);
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

  // Show dialog to update name
  void updateName(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Update Your Name"),
          content: Form(
            key: _formKey, // Associate the form key with the form
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                // Validate name: Check if it's empty or contains only spaces
                if (value == null || value.isEmpty) {
                  return "Please enter a valid name.";
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return "Name can only contain letters and spaces.";
                }
                return null; // Return null if validation passes
              },
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
              onPressed: () {
                // Check if the form is valid before saving the name
                if (_formKey.currentState?.validate() ?? false) {
                  updateDb(context); // Save the updated name to the database
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Update the database with the new name
  void updateDb(BuildContext context) async {
    final newName = nameController.text.trim();

    // If the name is not empty, update the profile
    if (newName.isNotEmpty) {
      // Fetch the existing profile from the ValueNotifier
      final userProfile = userProfileNotifier.value;

      if (userProfile != null) {
        // Create a new UserProfileModel with the updated name
        final updatedProfile = UserProfileModel(
          name: newName,
          email: userProfile.email,
          age: userProfile.age,
          hobbie: userProfile.hobbie,
          image: userProfile.image,
        );

        // Call the function to update the user profile in the database
        await editUserProfile(updatedProfile);

        // After updating the database, we also need to update the ValueNotifier
        userProfileNotifier.value = updatedProfile;  // This updates the UI
      }
    }
  }
}
