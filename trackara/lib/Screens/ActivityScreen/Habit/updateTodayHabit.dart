import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_functions.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';
import 'package:trackara/Screens/HomeScreen/homeScreen.dart';

List<String> updateDay = []; // To store selected days in full names

class Updatetodayhabit extends StatefulWidget {
  final int index;
  final ModelHabit value;
  const Updatetodayhabit({super.key, required this.index, required this.value});

  @override
  State<Updatetodayhabit> createState() => _UpdatetodayhabitState();
}

class _UpdatetodayhabitState extends State<Updatetodayhabit> {
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
        // Add the full day name to the updateDay list if selected
        updateDay.add(fullDayNames[index]);
      } else {
        // Remove the full day name from the updateDay list if deselected
        updateDay.remove(fullDayNames[index]);
      }
    });
  }

  final reminder = TextEditingController();
  final habitName = TextEditingController();
  List<String> getDate = [];

  @override
  void initState() {
    super.initState();
    // Set the initial values from the widget passed to the screen
    habitName.text = widget.value.name;
    reminder.text = widget.value.remider!;
    _selectedTime = widget.value.selectedTime;
    getDate.addAll(widget.value.selectedDays);

    // Initialize 'isSelectedDays' based on the selected days in the habit model
    for (int i = 0; i < fullDayNames.length; i++) {
      if (widget.value.selectedDays.contains(fullDayNames[i])) {
        isSelectedDays[i] = true; // Set the selected days to true
        updateDay.add(fullDayNames[i]); // Add the selected day to updateDay list
      }
    }
  }
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.of(context).pop();
        },),
        title: const Text(
          "CREATE NEW HABIT",
          style: TextStyle(fontFamily: "Mine", fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: habitName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "HABit Title",
                    hintStyle: TextStyle(color: Color(0xFFC1C0C0), fontSize: 20),
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Enter the Habit Name";
                    }else {
                      return null;
                    }
                  },
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
                                        validator: (value){
                    if(value==null||value.isEmpty){
                      return "Enter The Reminder";
                    }else {
                      return null;
                    }
                  },
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
                          if(_formKey.currentState!.validate()){
                            updateHabit();
                          }
                          // Here you can print or use the 'wantDay' list as needed
                          print("Selected Days: $updateDay");
                        },
                        child: Text(
                          "Update HABIT",
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

  Future<void> updateHabit() async {
    final title = habitName.text.trim();
    List<String> checkingDays = [];
    final remiderAdd = reminder.text.trim();
    checkingDays.addAll(widget.value.selectedDays);
    if (updateDay.isNotEmpty) {
      checkingDays.clear();
      checkingDays.addAll(updateDay);
      final selectedTime = _selectedTime;
      final newhabit = ModelHabit(
          name: title,
          selectedDays: checkingDays,
          remider: remiderAdd,
          selectedTime: selectedTime);
      await updateHabitNew(widget.index, newhabit);

      Navigator.of(context).pop();
      updateDay.clear();
    }
  }
}
