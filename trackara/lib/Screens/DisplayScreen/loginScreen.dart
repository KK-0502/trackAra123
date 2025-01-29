import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_userProfile.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset('assets/image/botimage.jpg'),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset('assets/image/topimage1.jpg'),
            ),
            Positioned(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Mine",
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Mine",
                        ),
                      ),
                      const SizedBox(height: 19),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 40,
                                offset: Offset(0, 45),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(15),
                            ),
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Enter Your UserName";
                              }else{
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Create",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Mine"),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                  addName(context);
                                }
                            },
                            child: Container(
                              width: 56,
                              height: 34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF4400FF),
                                    Color(0xFF00EEFF),
                                  ])),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add the user profile and set login state
  void addName(BuildContext context) async {
    String name = usernameController.text.trim();
    final newUserProfile = UserProfileModel(name: name); // Create the user profile model

    // Save the user profile to the database
    await addUserProfile(newUserProfile);

    // Set login state to true
    await setLoginState(true);

    // Navigate to the home page after login
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => NavigatorScreen()));
  }
}
