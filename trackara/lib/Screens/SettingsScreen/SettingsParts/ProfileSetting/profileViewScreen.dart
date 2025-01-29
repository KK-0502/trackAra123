import 'package:flutter/material.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/profileAge.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/profileEmail.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/profileHobbie.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/profileName.dart';

class Profileviewscreen extends StatelessWidget {
  const Profileviewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Profile Name Section
                          Profilename(),
                          SizedboxWidget(),
                          // Profile Age Section
                          ProfileAge(),
                          SizedboxWidget(),
                          // Profile Email Section
                          ProfileEmail(),
                          SizedboxWidget(),
                          // Profile Hobbies Section
                          Profilehobbie(),
                          SizedboxWidget(),
                          // Done Button
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.done_all_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
