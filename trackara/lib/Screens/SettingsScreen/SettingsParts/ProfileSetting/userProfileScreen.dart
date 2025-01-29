import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/profileViewScreen.dart';

class Userprofilescreen extends StatefulWidget {
  const Userprofilescreen({super.key});

  @override
  State<Userprofilescreen> createState() => _UserprofilescreenState();
}

class _UserprofilescreenState extends State<Userprofilescreen> {
  File? image;
  final picker = ImagePicker();
  String? imagePath;

  Future<void> getImage() async {
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickImage != null) {
        image = File(pickImage.path);
        imagePath = image!.path;
        print(imagePath);
      } else {
        print("no image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        await getImage();  // Wait for the image selection
        if (image != null) {
          updateDb(context);  // Update DB only if an image is selected
        }
      },
      child: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.35,
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<UserProfileModel?>(
                valueListenable: userProfileNotifier,
                builder: (BuildContext ctx, UserProfileModel? usertile, Widget? child) {
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,  // Make the container circular
                      color: Colors.green, // Fallback color if image is not loaded
                    ),
                    child: image != null
                      ? ClipOval(  // Clip the image to make it round
                          child: Image.file(image!.absolute, fit: BoxFit.cover),
                        )
                      : (usertile != null
                          ? ClipOval(  // Clip the loaded image to make it round
                              child: loadImage(usertile.image.toString()),
                            )
                          : Image.asset('assets/image/fav.png')), // Fallback to default image
                  );
                },
              ),
              SizedboxWidget(),
              ValueListenableBuilder<UserProfileModel?>(
                valueListenable: userProfileNotifier,
                builder: (BuildContext ctx, UserProfileModel? usertile, Widget? child) {
                  return Text(
                    usertile?.name ?? "No Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Mine",
                      fontSize: screenWidth * 0.04,
                    ),
                  );
                },
              ),
              SizedboxWidget(),
              ValueListenableBuilder<UserProfileModel?>(
                valueListenable: userProfileNotifier,
                builder: (BuildContext ctx, UserProfileModel? usertile, Widget? child) {
                  return Text(
                    usertile?.email ?? "No Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Mine",
                      fontSize: screenWidth * 0.04,
                    ),
                  );
                },
              ),
              SizedboxWidget(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return Profileviewscreen();
                  }));
                },
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mine",
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDb(BuildContext context) async {
    if (imagePath != null && imagePath!.isNotEmpty) {
      final userProfile = userProfileNotifier.value;
      if (userProfile != null) {
        final updatedProfile = UserProfileModel(
          name: userProfile.name,
          email: userProfile.email,
          age: userProfile.age,
          hobbie: userProfile.hobbie,
          image: imagePath!,  // Use the selected image path
        );

        await editUserProfile(updatedProfile);  // Update DB
        userProfileNotifier.value = updatedProfile;  // Update UI
      }
    } else {
      print("No image selected.");
    }
  }

  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(imagePath, fit: BoxFit.cover);
    } else {
      final imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        return Image.file(imageFile, fit: BoxFit.cover);
      } else {
        return Image.asset('assets/image/fav.png',fit: BoxFit.cover,);  // Fallback image
      }
    }
  }
}
