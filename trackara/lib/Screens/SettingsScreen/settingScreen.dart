import 'package:flutter/material.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/privacyAndPollicy.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/reprotScreen.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/termsAndCondition.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/userProfileScreen.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height to make the layout responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: [
                // Profile card container with responsive width and height
               Userprofilescreen(),

                SizedboxWidget(),

                // Settings options with responsive layout
                SizedBox(
                  height: 70,
                  width: screenWidth * 0.9, // Responsive width (90% of the screen width)
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return PrivacyAndPollicy();
                      }));
                    },
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 5, 192, 199),
                      elevation: 15,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Privacy And Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Mine",
                                fontSize: screenWidth * 0.04, // Responsive font size
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedboxWidget(),

                SizedBox(
                  height: 70,
                  width: screenWidth * 0.9, // Responsive width
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return TermsAndCondition();
                      }));
                    },
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 5, 192, 199),
                      elevation: 10,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Terms And Condition",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Mine",
                                fontSize: screenWidth * 0.04, // Responsive font size
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedboxWidget(),

                SizedBox(
                  height: 70,
                  width: screenWidth * 0.9, // Responsive width
                  child: GestureDetector(
                    onTap:(){
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                        return ReportScreen();
                       }));
                    },
                   
                    child: Card(
                      shadowColor: const Color.fromARGB(255, 5, 192, 199),
                      elevation: 10,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.report_gmailerrorred,
                              color: Colors.white,
                            ),
                            Text(
                              "Report",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Mine",
                                fontSize: screenWidth * 0.04, // Responsive font size
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedboxWidget(),

                // SizedBox(
                //   height: 70,
                //   width: screenWidth * 0.9, // Responsive width
                //   child: GestureDetector(
                //     child: Card(
                //       shadowColor: const Color.fromARGB(255, 5, 192, 199),
                //       elevation: 10,
                //       color: Colors.black,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Icon(
                //               Icons.logout_outlined,
                //               color: Colors.white,
                //             ),
                //             Text(
                //               "LogOut",
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontFamily: "Mine",
                //                 fontSize: screenWidth * 0.04, // Responsive font size
                //               ),
                //             ),
                //             Row(
                //               children: [
                //                 Icon(
                //                   Icons.arrow_forward_ios,
                //                   color: Colors.white,
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
