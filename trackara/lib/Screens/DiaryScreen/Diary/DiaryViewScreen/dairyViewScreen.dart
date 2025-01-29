// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:trackara/Model/DiaryModel/diary_model.dart';

// class DairyView extends StatefulWidget {
//   final DiaryModel diary;
//   final int index;
//   const DairyView({super.key,required this.diary,required this.index});

//   @override
//   State<DairyView> createState() => _DairyViewState();
// }

// class _DairyViewState extends State<DairyView> {
//   @override
//   Widget build(BuildContext context) {
//     int index=widget.index;
//     String image=widget.diary.image;
//     String date=widget.diary.date;
//     String time=widget.diary.time;
//     String title=widget.diary.titile;
//     String subject=widget.diary.subJect;
//     String  text=widget.diary.text;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: () {
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back)),
//         title: Text(
//           "Your  DIAry View",
//           style: TextStyle(fontFamily: "Mine", fontSize: 21),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 200,
//                   color: Colors.green,
//                   child: loadImage(image),
//                 ),
//                 Text(
//                   date,
//                   style: TextStyle(fontFamily: "Mine", fontSize: 14),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   time,
//                   style: TextStyle(fontFamily: "Mine", fontSize: 14),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(
//                       fontFamily: "Mine", fontSize: 20, color: Colors.red),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   subject,
//                   style: TextStyle(fontFamily: "Mine", fontSize: 14),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Text(
//                   text,
//                   style: TextStyle(fontFamily: "Mine", fontSize: 14),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
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
// }
