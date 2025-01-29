import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_functions.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';
import 'package:trackara/Screens/DisplayScreen/naviScreen.dart';
import 'package:trackara/Screens/HomeScreen/homeScreen.dart';

List<String> wantDay = []; // To store selected days in full names

class CreateHabit extends StatefulWidget {
  const CreateHabit({super.key});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  String? selectedTime;
  String _selectedTime = "Anytime";
  final List<String> timeOptions = [
    "Morning",
    "Afternoon",
    "Evening",
    "Night",
    "Anytime"
  ];
  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  List<String> fullDayNames = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  List<bool> isSelectedDays = [false, false, false, false, false, false, false];

  // Method to handle day selection/deselection and updating the 'wantDay' list
  void toggleDaySelection(int index) {
    setState(() {
      isSelectedDays[index] = !isSelectedDays[index];
      if (isSelectedDays[index]) {
        // Add the full day name to the wantDay list if selected
        wantDay.add(fullDayNames[index]);
      } else {
        // Remove the full day name from the wantDay list if deselected
        wantDay.remove(fullDayNames[index]);
      }
    });
  }

  final reminder = TextEditingController();
  final habitName = TextEditingController();
  bool isdataMatched=true;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: const Text(
          "CREATE NEW HABIT",
          style: TextStyle(fontFamily: "Mine", fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: habitName,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Enter Your Name";
                    }else{
                      return null;
                    }
                    
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "HABit Title",
                    hintStyle: TextStyle(color: Color(0xFFC1C0C0), fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // Choose Time in a Day
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Time In a Day",
                          style: TextStyle(fontFamily: "Mine", fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 8,
                            children: timeOptions.map((time) {
                              return ChoiceChip(
                                label: Text(time),
                                selected: _selectedTime == time,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedTime = time;
                                  });
                                },
                                selectedColor: Color(0xFFFFBD59),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Select Days
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select days",
                          style: TextStyle(fontFamily: "Mine", fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(days.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  toggleDaySelection(index);
                                },
                                child: CircleAvatar(
                                  backgroundColor: isSelectedDays[index]
                                      ? Color(0xFF00EEFF)
                                      : Color(0xFFFFFFFF),
                                  child: Text(days[index]),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Reminder portion
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reminder",
                          style: TextStyle(fontFamily: "Mine", fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Add Reminder";
                              }else{
                                return null;
                              }
                            },
                            readOnly: true,
                            controller: reminder,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "ADD ME",
                                hintStyle:
                                    TextStyle(fontFamily: "Mine", fontSize: 13),
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      TimeOfDay? selectedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (selectedTime != null) {
                                        reminder.text =
                                            selectedTime.format(context);
                                      }
                                    },
                                    icon:
                                        const Icon(Icons.watch_later_outlined))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Add habit portion
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Color(0xFF4000FF), Color(0xFF00EEFF)])),
                    child: TextButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            creatingHab(context);
                          }
                        },
                        child: Text(
                          "ADD HABIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Mine",
                              fontSize: 16),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> creatingHab(BuildContext context) async {
    final title = habitName.text.trim();
    List<String> checkingDays = [];
    final remiderAdd = reminder.text.trim();
    checkingDays.addAll(wantDay);
    final selectedTime = _selectedTime;
    if(checkingDays.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        content: 
      Text("Select Your Days"),
      ));
    }else{
      if(title.isNotEmpty&&checkingDays.isNotEmpty){
final sendHabit = ModelHabit(
        name: title,
        selectedDays: checkingDays,
        remider: remiderAdd,
        selectedTime: selectedTime);
    addHabit(sendHabit);
    wantDay.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return NavigatorScreen();
    }));
    }
    }
  }
}
