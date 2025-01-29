// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:trackara/Functions/db_doal.dart';
// import 'package:trackara/Model/GoalModel/goal_model.dart';

// class UpdateGoal extends StatefulWidget {
//   final GoalModel goal;
//   final int index;
//   const UpdateGoal({super.key,required this.goal,required this.index});

//   @override
//   State<UpdateGoal> createState() => _UpdateGoalState();
// }

// class _UpdateGoalState extends State<UpdateGoal> {
//   final dateOneController = TextEditingController();
//   final dateTwoController = TextEditingController();
//   final discriptionController = TextEditingController();
//   final amountController = TextEditingController();
//   final nameController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dateOneController.text=widget.goal.stratDate;
//     dateTwoController.text=widget.goal.endDate;
//     nameController.text=widget.goal.name;
//     amountController.text=widget.goal.amount.toString();
//     discriptionController.text=widget.goal.discription;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//         title: Text(
//           "Update Goal",
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
//                     readOnly: true,
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
//                     readOnly: true,
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.calendar_month_outlined)),
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
//                             onPressed: () {},
//                             icon: Icon(Icons.calendar_month_outlined)),
//                         border: OutlineInputBorder()),
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
//                           updateGoalValue();
//                         },
//                         child: Text(
//                           "UPDATE GOAl",
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

//   Future<void>updateGoalValue()async{
//     final name = nameController.text.trim();
//     final amount = int.tryParse(amountController.text.trim()) ?? 0;
//     final discription = dateTwoController.text.trim();
//     final stratDate = dateOneController.text.trim();
//     final endDate = dateTwoController.text.trim();
//     final image = widget.goal.image;
//     final addValue=widget.goal.addValue;
//     final newGoalUpdate = GoalModel(
//       name: name,
//        amount: amount,
//         discription: discription, 
//         stratDate: stratDate,
//          endDate: endDate,
//           image: image,
//           addValue: addValue
//           );

//           await updateGoal(widget.index, newGoalUpdate);
//           Navigator.of(context).pop();
//   }
// }
