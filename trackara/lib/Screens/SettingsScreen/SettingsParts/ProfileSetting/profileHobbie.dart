import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';

class Profilehobbie extends StatelessWidget {
   Profilehobbie({super.key});
  final hobbieController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
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
                                        userList?.hobbie ?? "No Hobbies", // Safe check for null
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
  void updateName(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Update Your Name"),
          content: TextFormField(
            controller: hobbieController, // Use separate controller for update
            decoration: InputDecoration(
              hintText: "Name",
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
              onPressed: ()async {
                await updateDb(context); // Save the updated name to the database
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
    final newHobbie = hobbieController.text.trim();

    // If the name is not empty, update the profile
    if (newHobbie.isNotEmpty) {
      // Fetch the existing profile from the ValueNotifier
      final userProfile = userProfileNotifier.value;

      if (userProfile != null) {
        // Create a new UserProfileModel with the updated name
        final updatedProfile = UserProfileModel(
          name: userProfile.name,
          email: userProfile.email,
          age: userProfile.age,
          hobbie: newHobbie,
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