import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trackara/Functions/db_doal.dart';
import 'package:trackara/Model/GoalModel/goal_model.dart';
import 'package:trackara/Screens/CommonWidget/sizedBox.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';
late int indexOne;
class ViewGoalScreen extends StatefulWidget {
  final GoalModel goal;
  final int index;
  const ViewGoalScreen({super.key, required this.goal, required this.index});

  @override
  State<ViewGoalScreen> createState() => _ViewGoalScreenState();
}

class _ViewGoalScreenState extends State<ViewGoalScreen> {
  final addvalueController = TextEditingController();
  final decreaseValueController =
      TextEditingController(); // Separate controller for decrease
  int goalAddValue = 0; // State to store the goal's add value
  final updateAmountController = TextEditingController();
  final updateDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    goalAddValue =
        widget.goal.addValue ?? 0; // Initialize with current addValue
        
  }
  final _formKey=GlobalKey<FormState>();
  final _dateKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
     indexOne = widget.index;
    String goalName = widget.goal.name;
    String amount = widget.goal.amount.toString();
    String stratDate = widget.goal.stratDate;
    String endDate = widget.goal.endDate;
    String image = widget.goal.image;
    String discription = widget.goal.discription;

    // Calculate the percentage progress towards the goal
    double goalAmount = widget.goal.amount?.toDouble() ?? 0.0;
    double percentage =
        (goalAmount > 0) ? (goalAddValue / goalAmount) * 100 : 0.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () async {
                deleteScreen(context);
              },
              icon: Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image/Card section
                SizedBox(
                  width: screenWidth * 0.4, // Responsive width
                  height: screenWidth * 0.4, // Responsive height
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: loadImage(image),
                  ),
                ),
                SizedboxWidget(),
                // Goal Name
                Text(
                  goalName,
                  style: TextStyle(
                      fontSize: screenWidth * 0.04), // Adjust text size
                ),
                Divider(
                  color: Color(0xFF99763d),
                ),
                Row(
                  children: [
                    Icon(MdiIcons.target),
                    SizedBox(
                        width:
                            screenWidth * 0.02), // Space between icon and text
                    Text(endDate),
                    SizedBox(width: screenWidth * 0.02),
                    GestureDetector(
                        onTap: () {
                          return updateDate(context);
                        },
                        child: Icon(Icons.edit_note_outlined)),
                  ],
                ),
                Divider(
                  color: Color(0xFF99763d),
                ),
                SizedboxWidget(),
                // Amount Section
                Text(
                  "Adding amount && Amount Goal",
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedboxWidget(),
                // Add Amount Card
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.07, // Responsive height
                  child: Card(
                    color: Colors.white,
                    elevation: 15,
                    child: Center(
                        child: Text(
                      goalAddValue.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04), // Responsive font size
                    )),
                  ),
                ),
                SizedboxWidget(),
                // Goal Amount Card
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.07, // Responsive height
                  child: Card(
                    color: Colors.white,
                    elevation: 15,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("             "),
                        Text(
                          amount,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        IconButton(
                            onPressed: () {
                              addMoreAmount(context);
                            },
                            icon: Icon(Icons.edit_note_outlined))
                      ],
                    )),
                  ),
                ),
                SizedboxWidget(),
                // Progress
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.07, // Responsive height
                  child: Card(
                    color: Colors.white,
                    elevation: 15,
                    child: Center(
                        child: Text(
                      "${percentage.toStringAsFixed(2)}% completed",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    )),
                  ),
                ),
                SizedboxWidget(),
                Divider(
                  color: Color(0xFF99763d),
                ),
                SizedboxWidget(),
                // Goal Description
                Text(
                  "Goal Description",
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedboxWidget(),
                // Goal Description Card
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.07, // Responsive height
                  child: Card(
                    color: Colors.white,
                    elevation: 15,
                    child: Center(
                        child: Text(
                      discription,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    )),
                  ),
                ),
                SizedboxWidget(),
                Divider(
                  color: Color(0xFF99763d),
                ),
                SizedboxWidget(),
                // Start Date Section
                Text(
                  "Start Date",
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                Text(
                  stratDate,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedboxWidget(),
                // Start and End Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: screenWidth * 0.4, // Adjust width dynamically
                      height: screenHeight * 0.07, // Adjust height dynamically
                      color: Colors.lightGreen,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            addValue(context);
                          },
                          icon: Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.4, // Adjust width dynamically
                      height: screenHeight * 0.07, // Adjust height dynamically
                      color: Colors.red,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            minaseValue(context);
                          },
                          icon: Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
      return Image.network(imagePath, fit: BoxFit.cover);
    } else {
      File imageFile = File(imagePath);
      if (imageFile.existsSync()) {
        return Image.file(imageFile, fit: BoxFit.cover);
      } else {
        return Image.asset(
            'assets/image/fav.png'); // Fallback to default image if file not found
      }
    }
  }

  void addValue(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Add Value"),
            content: TextFormField(
              controller: addvalueController,
              decoration: InputDecoration(
                hintText: "Add Value",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    addFunction();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  // Function to show the dialog for decreasing value
  void minaseValue(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Decrease Value"),
            content: TextFormField(
              controller:
                  decreaseValueController, // Use separate controller for decrease
              decoration: InputDecoration(
                hintText: "Decrease Value",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    dicreaseFunction();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  // Function to handle adding value
  void addFunction() {
    final incValue = int.tryParse(addvalueController.text.trim()) ?? 0;
    setState(() {
      goalAddValue += incValue;
    });

    final newGoalU = GoalModel(
      name: widget.goal.name,
      amount: widget.goal.amount,
      discription: widget.goal.discription,
      stratDate: widget.goal.stratDate,
      endDate: widget.goal.endDate,
      image: widget.goal.image,
      addValue: goalAddValue,
    );

    updateGoal(widget.index,
        newGoalU); // Assuming updateGoal function updates the goal in your database
    addvalueController.clear(); // Clear input after saving
  }

  // Function to handle decreasing value
  void dicreaseFunction() {
    final decValue = int.tryParse(decreaseValueController.text.trim()) ?? 0;
    setState(() {
      goalAddValue -= decValue; // Decrease the value
    });

    final newGoalU = GoalModel(
      name: widget.goal.name,
      amount: widget.goal.amount,
      discription: widget.goal.discription,
      stratDate: widget.goal.stratDate,
      endDate: widget.goal.endDate,
      image: widget.goal.image,
      addValue: goalAddValue,
    );

    updateGoal(widget.index,
        newGoalU); // Assuming updateGoal function updates the goal in your database
    decreaseValueController.clear(); // Clear input after saving
  }

  void addMoreAmount(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Update Your Amount"),
            content: Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller:
                    updateAmountController, // Use separate controller for update
                decoration: InputDecoration(
                  hintText: "Amount",
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null||value.isEmpty){
                    return "Value is Empty";
                  }else{
                    return null;
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      updateAmount();
                    Navigator.of(context).pop();
                    }
                    
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  void updateAmount() {
    final updateValue = int.tryParse(updateAmountController.text.trim()) ?? 0;

    final newGoalU = GoalModel(
      name: widget.goal.name,
      amount: updateValue,
      discription: widget.goal.discription,
      stratDate: widget.goal.stratDate,
      endDate: widget.goal.endDate,
      image: widget.goal.image,
      addValue: goalAddValue,
    );

    updateGoal(widget.index,
        newGoalU); // Assuming updateGoal function updates the goal in your database

    // Trigger a rebuild and update the goal amount in the UI
    setState(() {
      widget.goal.amount = updateValue;
    });

    updateAmountController.clear(); // Clear input after saving
  }

  void updateDate(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Update Your End date"),
            content: Form(
              key: _dateKey,
              child: TextFormField(
                controller:
                    updateDateController, // Use separate controller for update
                decoration: InputDecoration(
                    hintText: "Date",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          endDate();
                        },
                        icon: Icon(Icons.calendar_today_outlined))),
                        validator: (value){
                  if(value==null||value.isEmpty){
                    return "Date is Empty";
                  }else{
                    return null;
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if(_dateKey.currentState!.validate()){
                      updateDateDB();
                    Navigator.of(context).pop();
                    }
                    
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  Future<void> endDate() async {
    final DateTime? datetwo = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2300).add(Duration(days: 365)));

    final formateDateTwo = DateFormat("dd-MM-yyyy").format(datetwo!);
    setState(() {
      updateDateController.text = formateDateTwo.toString();
    });
  }

  void updateDateDB() {
    final updateDate = updateDateController.text.trim();
    final newGoalU = GoalModel(
      name: widget.goal.name,
      amount: widget.goal.amount,
      discription: widget.goal.discription,
      stratDate: widget.goal.stratDate,
      endDate: updateDate,
      image: widget.goal.image,
      addValue: goalAddValue,
    );

    updateGoal(widget.index,
        newGoalU); // Assuming updateGoal function updates the goal in your database

    // Trigger a rebuild and update the goal amount in the UI
    setState(() {
      widget.goal.endDate = updateDate;
    });
  }
  void deleteScreen(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                "Are You Sure",
                style: TextStyle(
                    color: Colors.red, fontSize: 20, fontFamily: "Mine"),
              ),
            ),
            content: Icon(
              Icons.delete_forever_outlined,
              size: 50,
              color: Colors.red,
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    await  deleteGoal(indexOne);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1){
                      return NavigatorScreen();
                    }));
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.red, fontFamily: "Mine"),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "cancel",
                    style: TextStyle(color: Colors.green, fontFamily: "Mine"),
                  )),
            ],
          );
        });
  }
}
