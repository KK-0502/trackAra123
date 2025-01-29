// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:trackara/Functions/db_doal.dart';
// import 'dart:io';

// import 'package:trackara/Model/GoalModel/goal_model.dart';
// import 'package:trackara/Screens/HomeScreen/homeScreen.dart';

// class CreateGoal extends StatefulWidget {
//   const CreateGoal({super.key});

//   @override
//   State<CreateGoal> createState() => _CreateGoalState();
// }

// class _CreateGoalState extends State<CreateGoal> {
//   final formateDate=DateFormat("dd-MM-yyyy").format(DateTime.now());
//   final dateOneController = TextEditingController();
//   final dateTwoController = TextEditingController();
//   final discriptionController = TextEditingController();
//   final amountController = TextEditingController();
//   final nameController = TextEditingController();

//   File? image;
//   final picker = ImagePicker();
//   String? imagePath;

//   Future<void> getImage() async {
//     final pickImage = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickImage != null) {
//         image = File(pickImage.path);
//         imagePath = image!.path;
//         print(imagePath);
//       } else {
//         print("no image selected");
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       dateOneController.text=formateDate.toString();
      
//     });
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//         title: Text(
//           "Create A Goal",
//           style: TextStyle(fontFamily: "Mine", fontSize: 20),
//         ),
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Goal Name",
//                     style: TextStyle(
//                       fontFamily: "Mine",
//                       fontSize: 14,
//                     ),
//                   ),
//                   TextFormField(
                    
//                     controller: nameController,
//                     decoration: InputDecoration(border: OutlineInputBorder()),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Goal Amount",
//                     style: TextStyle(
//                       fontFamily: "Mine",
//                       fontSize: 14,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: amountController,
//                     decoration: InputDecoration(border: OutlineInputBorder()),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Text(
//                     "Goal Discription",
//                     style: TextStyle(
//                       fontFamily: "Mine",
//                       fontSize: 14,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: discriptionController,
//                     decoration: InputDecoration(border: OutlineInputBorder()),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Start Date",
//                     style: TextStyle(
//                       fontFamily: "Mine",
//                       fontSize: 14,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: dateOneController,
//                     decoration: InputDecoration(
                        
//                         border: OutlineInputBorder()),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "End Date",
//                     style: TextStyle(
//                       fontFamily: "Mine",
//                       fontSize: 14,
//                     ),
//                   ),
//                   TextFormField(
//                     controller: dateTwoController,
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               endDate();
//                             },
//                             icon: Icon(Icons.calendar_month_outlined)),
//                         border: OutlineInputBorder()),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: Text(
//                       "Set A Image",
//                       style: TextStyle(
//                         fontFamily: "Mine",
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: InkWell(
//                       onTap: getImage,
//                       child: Container(
//                           width: 150,
//                           height: 150,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey)),
//                           child: image != null
//                               ? Image.file(
//                                   image!.absolute,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Center(
//                                   child: Icon(Icons.camera),
//                                 )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                             colors: [Color(0xFF4000FF), Color(0xFF00EEFF)]),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextButton(
//                         onPressed: () {
//                           getGoal();
//                         },
//                         child: Text(
//                           "CREATE GOAl",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: "Mine",
//                               fontSize: 16),
//                         )),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }

  

//   Future<void> endDate() async {
//     final DateTime? datetwo = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2300).add(Duration(days: 365)));

//     final formateDateTwo = DateFormat("dd-MM-yyyy").format(datetwo!);
//     setState(() {
//       dateTwoController.text = formateDateTwo.toString();
//     });
//   }

//   void getGoal() {
//     final name = nameController.text.trim();
//     final amount = int.tryParse(amountController.text.trim()) ?? 0;
//     final discription = dateTwoController.text.trim();
//     final startDate = dateOneController.text.trim();
//     final endDate = dateTwoController.text.trim();
//     final image = imagePath!;

//     final newGoal = GoalModel(
//         name: name,
//         amount: amount,
//         discription: discription,
//         stratDate: startDate,
//         endDate: endDate,
//         image: image);

//         addGoal(newGoal);

//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1){
//           return Homescreen();
//         }));
//   }
// }
