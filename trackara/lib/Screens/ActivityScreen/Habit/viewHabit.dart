import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_functions.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/updateTodayHabit.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';

late int index;

class ViewHabit extends StatefulWidget {
  final ModelHabit habit;
  final int index;
  ViewHabit({super.key, required this.habit, required this.index});

  @override
  State<ViewHabit> createState() => _ViewHabitState();
}

class _ViewHabitState extends State<ViewHabit> {
  @override
  Widget build(BuildContext context) {
    index = widget.index;
    String habitName = widget.habit.name;
    String habitTime = widget.habit.selectedTime;
    List<String> selectedDays = widget.habit.selectedDays;
    String? remider = widget.habit.remider;
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF4400FF), Color(0xFF00EEFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Center(
            child: Container(
              width: 300,
              height: 600,
              color: Colors.white,
              child: Stack(children: [
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Image.asset('assets/image/botimage.jpg')),
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Image.asset('assets/image/topimage1.jpg')),
                Positioned(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HABit View",
                              style: TextStyle(
                                fontFamily: "Mine",
                                fontSize: 16,
                                color: Color(0xFF4400FF),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (ctx) {
                                        return Updatetodayhabit(
                                            index: widget.index,
                                            value: widget.habit);
                                      }));
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async {
                                      deleteScreen(context);
                                      // await deleteHabit(index);
                                      // Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your Habit",
                        style: TextStyle(fontFamily: "Mine", fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          habitName,
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 20,
                            color: Color(0xFF4400FF),
                          ),
                        )),
                      ),
                      Text(
                        "Selected Time",
                        style: TextStyle(fontFamily: "Mine", fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          habitTime,
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 20,
                            color: Color(0xFF4400FF),
                          ),
                        )),
                      ),
                      Text(
                        "Selected Time",
                        style: TextStyle(fontFamily: "Mine", fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          selectedDays.toString(),
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 14,
                            color: Color(0xFF4400FF),
                          ),
                        )),
                      ),
                      Text(
                        "Selected Reminder",
                        style: TextStyle(fontFamily: "Mine", fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          remider!,
                          style: TextStyle(
                            fontFamily: "Mine",
                            fontSize: 20,
                            color: Color(0xFF4400FF),
                          ),
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            label: Text("Back"),
                            icon: Icon(Icons.home),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ]),
            ),
          )),
    );
  }

  void deleteScreen(BuildContext context){
    showDialog(
        context: context,
        builder: (ctx1) {
          return AlertDialog(
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
                    await deleteHabit(index);
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
