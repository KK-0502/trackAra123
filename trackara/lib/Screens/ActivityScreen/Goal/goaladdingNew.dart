import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trackara/Functions/db_doal.dart';
import 'package:trackara/Model/GoalModel/goal_model.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';
import 'package:trackara/Screens/HomeScreen/homeScreen.dart';

class GoalAddingScreen extends StatefulWidget {
  const GoalAddingScreen({super.key});

  @override
  State<GoalAddingScreen> createState() => _GoalAddingScreenState();
}

class _GoalAddingScreenState extends State<GoalAddingScreen> {
  final formateDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final dateOneController = TextEditingController();
  final dateTwoController = TextEditingController();
  final discriptionController = TextEditingController();
  final amountController = TextEditingController();
  final nameController = TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      dateOneController.text = formateDate.toString();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Create New Goal"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: const [
                  Color(0xFFf5e6a4),
                  Color(0xFF99763d),
                ])),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  getGoal();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Goal Name Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Goal Name"),
                      GestureDetector(
                        onTap: getImage,
                        child: ClipOval(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: image != null
                                ? Image.file(
                                    image!.absolute,
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Icon(Icons.cameraswitch_outlined),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "-Enter your Goal Name-"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Goal";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedboxWidget(),

                  // Amount Section
                  Text("Amount"),
                  SizedboxWidget(),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "-Enter Your Goal Amount-"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Goal Amount";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedboxWidget(),
                  Divider(
                    color: Color(0xFF99763d),
                  ),
                  SizedboxWidget(),

                  // Description Section
                  Text("Description"),
                  SizedboxWidget(),
                  TextFormField(
                    controller: discriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "-Description about your Goal-"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Disccription";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedboxWidget(),
                  Divider(
                    color: Color(0xFF99763d),
                  ),
                  SizedboxWidget(),

                  // Date Section
                  Text("Starting Date && End Date"),
                  SizedboxWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Start Date Field
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(),
                          child: TextFormField(
                            controller: dateOneController,
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "-Start Date-",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05), // Add spacing between the two date fields

                      // End Date Field
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(),
                          child: TextFormField(
                            controller: dateTwoController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    endDate();
                                  },
                                  icon: Icon(Icons.calendar_month_outlined)),
                              border: OutlineInputBorder(),
                              hintText: "-End Date-",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Your End Date";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedboxWidget(),
                  Divider(
                    color: Color(0xFF99763d),
                  ),
                  SizedboxWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> endDate() async {
    final DateTime? datetwo = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2300).add(Duration(days: 365)));

    final formateDateTwo = DateFormat("dd-MM-yyyy").format(datetwo!);
    setState(() {
      dateTwoController.text = formateDateTwo.toString();
    });
  }

  void getGoal() {
    final name = nameController.text.trim();
    final amount = int.tryParse(amountController.text.trim()) ?? 0;
    final discription = discriptionController.text.trim();
    final startDate = dateOneController.text.trim();
    final endDate = dateTwoController.text.trim();
    final image = imagePath!;

    final newGoal = GoalModel(
        name: name,
        amount: amount,
        discription: discription,
        stratDate: startDate,
        endDate: endDate,
        image: image);

    addGoal(newGoal);

    Navigator.of(context).pop();
  }
}
