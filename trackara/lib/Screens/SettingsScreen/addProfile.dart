// import 'package:flutter/material.dart';


// class AddProfile extends StatefulWidget {
//   const AddProfile({super.key});

//   @override
//   State<AddProfile> createState() => _AddProfileState();
// }

// class _AddProfileState extends State<AddProfile> {
//   final nameController=TextEditingController();
//   final ageController=TextEditingController();
//   final emailController=TextEditingController();
//   final habitController=TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back)),
//         centerTitle: true,
//         title: Text("Profile",style: TextStyle(
//           fontFamily: "Mine",
//           fontSize: 29,
//         ),),
//         actions: [
//           IconButton(onPressed: (){}, icon:Icon(Icons.person))
//         ],
//       ),
//       body: SafeArea(child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
              
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage("assets/image/batman.jpg"),
//                 ),
//                 SizedBox(height: 20,),
//                 Text("Name",style: TextStyle(
//                   fontFamily: "Mine",
//                   fontSize: 14
//                 ),),
//                 TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 15,),
//                 Text("Age",style: TextStyle(
//                   fontFamily: "Mine",
//                   fontSize: 14
//                 ),),
//                 TextFormField(
//                   controller: ageController,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 15,),
//                 Text("Email",style: TextStyle(
//                   fontFamily: "Mine",
//                   fontSize: 14
//                 ),),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 15,),
//                 Text("What is your favorite hobie",style: TextStyle(
//                   fontFamily: "Mine",
//                   fontSize: 14
//                 ),),
//                 TextFormField(
//                   controller: habitController,
//                   decoration: InputDecoration(
                    
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)
//                     )
//                   ),
//                 ),
//                 SizedBox(height: 15,),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: [
//                         Color(0xFF4000FF),
//                         Color(0xFF00EEFF)
//                       ]),
//                       borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(
//                       child: GestureDetector(
//                         onTap: (){
//                           saveProfile();
//                         },
//                         child: Text("SAVE",style: TextStyle(
//                           fontFamily: "Mine",
//                           fontSize: 24,
//                           color: Colors.white
//                         ),),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
//   Future<void> saveProfile()async{
//     final name=nameController.text.trim();
//     final age=int.tryParse(ageController.text) ?? 0;
//     final email=emailController.text.trim();
//     final habit=habitController.text.trim();

    
//    Navigator.of(context).pop();
//   }

// }