import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Screens/DisplayScreen/loginScreen.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoHomeOrLogin(); // Check login state on splash screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4400FF),
              Color(0xFF00EEFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animation/track2.json"),
            const Center(
              child: Text(
                "WELCOME TO TRACKARA",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Mine",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Check if the user is logged in or not
  Future<void> gotoHomeOrLogin() async {
    await Future.delayed(Duration(seconds: 5)); // Simulate splash screen delay

    // Check login state
    bool isLoggedIn = await getLoginState();

    // Navigate to the appropriate screen based on the login state
    if (isLoggedIn) {
      await getUserProfile();  // Fetch user profile from Hive

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => NavigatorScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }
  }
}
