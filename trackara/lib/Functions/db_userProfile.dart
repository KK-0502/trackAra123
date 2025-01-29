import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';

// Declare the ValueNotifier for the user profile
ValueNotifier<UserProfileModel?> userProfileNotifier = ValueNotifier<UserProfileModel?>(null);

// Function to set the login state (whether the user is logged in)
Future<void> setLoginState(bool isLoggedIn) async {
  final loginBox = await Hive.openBox('loginState');
  await loginBox.put('isLoggedIn', isLoggedIn);
}

// Function to get the login state from Hive
Future<bool> getLoginState() async {
  final loginBox = await Hive.openBox('loginState');
  bool isLoggedIn = loginBox.get('isLoggedIn', defaultValue: false);
  return isLoggedIn;
}

// Function to add a user profile to the database and update the ValueNotifier
Future<void> addUserProfile(UserProfileModel value) async {
  final userProfileBoxDB = await Hive.openBox<UserProfileModel>("UserProfile_db");
  
  // Save or update the user profile
  await userProfileBoxDB.put('userProfile', value);
  
  // Update the user profile notifier with the new profile
  userProfileNotifier.value = value;
}

// Function to get the user profile from Hive and update the ValueNotifier
Future<void> getUserProfile() async {
  final userProfileBoxDB = await Hive.openBox<UserProfileModel>("UserProfile_db");
  UserProfileModel? userProfile = userProfileBoxDB.get('userProfile');
  
  // Update the notifier whenever the user profile is fetched
  userProfileNotifier.value = userProfile;
}

// Function to edit an existing user profile and update it in the database
Future<void> editUserProfile(UserProfileModel updatedProfile) async {
  final userProfileBoxDB = await Hive.openBox<UserProfileModel>("UserProfile_db");

  // Update the existing profile with new data
  await userProfileBoxDB.put('userProfile', updatedProfile);
  
  // Optionally log the database update for debugging
  print("Updated profile in database");

  // Update the user profile notifier with the new profile
  userProfileNotifier.value = updatedProfile;  // Ensure the ValueNotifier is updated
}

