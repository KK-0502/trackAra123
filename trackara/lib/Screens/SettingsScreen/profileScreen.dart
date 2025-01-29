// import 'package:flutter/material.dart';
// import 'package:trackara/Screens/SettingsScreen/addProfile.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

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
//           IconButton(onPressed: (){
//             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddProfile()));
//           }, icon:Icon(Icons.person))
//         ],
//       ),
//       body: SafeArea(child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child:  Column(
                
//                 children: [
                   
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage("assets/image/batman.jpg"),
//                   ),
//                   SizedBox(height: 20,),
//                   Text("Name",style: TextStyle(
//                     fontFamily: "Mine",
//                     fontSize: 14
//                   ),),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//                   Text("Age",style: TextStyle(
//                     fontFamily: "Mine",
//                     fontSize: 14
//                   ),),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//                   Text("Email",style: TextStyle(
//                     fontFamily: "Mine",
//                     fontSize: 14
//                   ),),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.edit)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//                   Text("What is your favorite hobie",style: TextStyle(
//                     fontFamily: "Mine",
//                     fontSize: 14
//                   ),),
//                   TextFormField(
                    
//                     decoration: InputDecoration(
                      
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15)
//                       )
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//                 ],
//               )
              
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }