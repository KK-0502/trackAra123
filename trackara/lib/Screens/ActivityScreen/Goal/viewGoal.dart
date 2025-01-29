// import 'package:flutter/material.dart';
// import 'package:trackara/Functions/db_doal.dart';
// import 'package:trackara/Model/GoalModel/goal_model.dart';
// import 'package:trackara/Screens/ActivityScreen/Goal/updateGoalScreen.dart';
// import 'dart:io';

// class ViweGoal extends StatefulWidget {
//   final GoalModel goal;
//   final int index;

//   const ViweGoal({super.key, required this.goal, required this.index});

//   @override
//   State<ViweGoal> createState() => _ViweGoalState();
// }

// class _ViweGoalState extends State<ViweGoal> {
//   final addvalueController = TextEditingController();
//   final decreaseValueController = TextEditingController(); // Separate controller for decrease
//   int goalAddValue = 0; // State to store the goal's add value

//   @override
//   void initState() {
//     super.initState();
//     goalAddValue = widget.goal.addValue ?? 0; // Initialize the goalAddValue with the current addValue from the goal model.
//   }

//   @override
//   Widget build(BuildContext context) {
//     int index = widget.index;
//     String goalName = widget.goal.name;
//     String amount = widget.goal.amount.toString();
//     String stratDate = widget.goal.stratDate;
//     String endDate = widget.goal.endDate;
//     String image = widget.goal.image;

//     // Calculate the percentage progress towards the goal
//     double goalAmount = widget.goal.amount?.toDouble() ?? 0.0;
//     double percentage = (goalAmount > 0) ? (goalAddValue / goalAmount) * 100 : 0.0;

//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.black, Colors.red],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Container(
//             width: 300,
//             height: 600,
//             color: Colors.white,
//             child: Stack(children: [
//               Positioned(bottom: 0, right: 0, left: 0, child: Image.asset('assets/image/botimage.jpg')),
//               Positioned(top: 0, right: 0, left: 0, child: Image.asset('assets/image/topimage1.jpg')),
//               Positioned(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
                                
//                                 IconButton(
//                                   onPressed: () async {
//                                     await deleteGoal(index);
//                                     Navigator.of(context).pop();
//                                   },
//                                   icon: Icon(Icons.delete),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(width: 250, height: 150, child: loadImage(image)),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 75,
//                             height: 50,
//                             color: const Color.fromARGB(255, 10, 216, 17),
//                             child: Center(
//                               child: IconButton(
//                                 onPressed: () {
//                                   addValue(context); // Add value action
//                                 },
//                                 icon: Icon(Icons.arrow_upward),
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Container(
//                             width: 75,
//                             height: 50,
//                             color: Colors.red,
//                             child: Center(
//                               child: IconButton(
//                                 onPressed: () {
//                                   minaseValue(context); // Decrease value action
//                                 },
//                                 icon: Icon(Icons.arrow_downward),
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Text(goalName, style: TextStyle(fontFamily: "Mine", fontSize: 18)),
//                       Text("--Your goal is your dream--"),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(goalAddValue.toString()), // Display the updated value
//                           SizedBox(width: 5),
//                           Text("/", style: TextStyle(fontFamily: "Mine")),
//                           SizedBox(width: 5),
//                           Text(amount, style: TextStyle(fontFamily: "Mine")),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       // Display the percentage progress
//                       Text("${percentage.toStringAsFixed(2)}% completed", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Starting date", style: TextStyle(fontFamily: "Mine")),
//                               SizedBox(height: 5),
//                               Text("Ending Date", style: TextStyle(fontFamily: "Mine")),
//                               SizedBox(height: 5),
//                               Text("Remaining Date", style: TextStyle(fontFamily: "Mine")),
//                               SizedBox(height: 5),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(stratDate, style: TextStyle(fontFamily: "Mine")),
//                                   SizedBox(height: 5),
//                                   Text(endDate, style: TextStyle(fontFamily: "Mine")),
//                                   SizedBox(height: 5),
//                                   Text("3 years", style: TextStyle(fontFamily: "Mine")),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ]), 
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to load image dynamically
//   Widget loadImage(String imagePath) {
//     if (imagePath.startsWith('assets/')) {
//       return Image.asset(imagePath, fit: BoxFit.cover);
//     } else if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
//       return Image.network(imagePath, fit: BoxFit.cover);
//     } else {
//       File imageFile = File(imagePath);
//       if (imageFile.existsSync()) {
//         return Image.file(imageFile, fit: BoxFit.cover);
//       } else {
//         return Image.asset('assets/image/fav.png'); // Fallback to default image if file not found
//       }
//     }
//   }

//   // Function to show the dialog for adding value
//   void addValue(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (ctx1) {
//           return AlertDialog(
//             title: Text("Add Value"),
//             content: TextFormField(
//               controller: addvalueController,
//               decoration: InputDecoration(
//                 hintText: "Add Value",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(onPressed: () {
//                 Navigator.of(context).pop();
//               }, child: Text("Cancel")),
//               TextButton(onPressed: () {
//                 addFunction();
//                 Navigator.of(context).pop();
//               }, child: Text("Save")),
//             ],
//           );
//         });
//   }

//   // Function to show the dialog for decreasing value
//   void minaseValue(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (ctx1) {
//           return AlertDialog(
//             title: Text("Decrease Value"),
//             content: TextFormField(
//               controller: decreaseValueController, // Use separate controller for decrease
//               decoration: InputDecoration(
//                 hintText: "Decrease Value",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             actions: [
//               TextButton(onPressed: () {
//                 Navigator.of(context).pop();
//               }, child: Text("Cancel")),
//               TextButton(onPressed: () {
//                 dicreaseFunction();
//                 Navigator.of(context).pop();
//               }, child: Text("Save")),
//             ],
//           );
//         });
//   }

//   // Function to handle adding value
//   void addFunction() {
//     final incValue = int.tryParse(addvalueController.text.trim()) ?? 0;
//     setState(() {
//       goalAddValue += incValue;
//     });

//     final newGoalU = GoalModel(
//       name: widget.goal.name,
//       amount: widget.goal.amount,
//       discription: widget.goal.discription,
//       stratDate: widget.goal.stratDate,
//       endDate: widget.goal.endDate,
//       image: widget.goal.image,
//       addValue: goalAddValue,
//     );
    
//     updateGoal(widget.index, newGoalU);  // Assuming updateGoal function updates the goal in your database
//     addvalueController.clear();  // Clear input after saving
//   }

//   // Function to handle decreasing value
//   void dicreaseFunction() {
//     final decValue = int.tryParse(decreaseValueController.text.trim()) ?? 0;
//     setState(() {
//       goalAddValue -= decValue;  // Decrease the value
//     });

//     final newGoalU = GoalModel(
//       name: widget.goal.name,
//       amount: widget.goal.amount,
//       discription: widget.goal.discription,
//       stratDate: widget.goal.stratDate,
//       endDate: widget.goal.endDate,
//       image: widget.goal.image,
//       addValue: goalAddValue,
//     );
    
//     updateGoal(widget.index, newGoalU);  // Assuming updateGoal function updates the goal in your database
//     decreaseValueController.clear();  // Clear input after saving
//   }
// }
