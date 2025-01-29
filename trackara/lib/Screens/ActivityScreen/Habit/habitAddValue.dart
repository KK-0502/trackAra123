import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackara/Functions/db_functions.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/viewHabit.dart';
import 'package:trackara/Screens/HomeScreen/homeScreen.dart';

int totalHabits = 0;
int completedHabits = 0;

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  late List<bool> selectedIndex; // Define selectedIndex here

  @override
  void initState() {
    super.initState();
    selectedIndex = []; // Initialize selectedIndex list
  }

  // Load the saved checkbox states from shared preferences for a specific day
  Future<void> _loadCheckboxState(List<ModelHabit> habitList) async {
    final prefs = await SharedPreferences.getInstance();
    final savedState = prefs.getStringList('habitCheckboxState_$selectedDay') ?? [];

    setState(() {
      selectedIndex = List.generate(
        habitList.length,
        (index) => savedState.length > index ? savedState[index] == 'true' : false,
      );
    });
  }

  // Save the checkbox states to shared preferences for a specific day
  Future<void> _saveCheckboxState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedState = selectedIndex.map((e) => e.toString()).toList();
    await prefs.setStringList('habitCheckboxState_$selectedDay', savedState);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: addHabitNotify, // This listens for changes to the habit list
      builder: (BuildContext ctx, List<ModelHabit> habitList, Widget? child) {
        // Filter habits for the selected day
        final visibleHabits = habitList.where((habit) => habit.selectedDays.contains(selectedDay)).toList();

        // If no habits are assigned to the selected day, show a "No habits available" message
        if (visibleHabits.isEmpty) {
          return Center(child: Text("No habits available for $selectedDay"));
        }

        totalHabits = habitList.length;

        // Ensure selectedIndex has the correct length based on visibleHabits length
        if (selectedIndex.length != visibleHabits.length) {
          selectedIndex = List.generate(visibleHabits.length, (index) => false);
          _loadCheckboxState(visibleHabits); // Load the saved state after resetting
        }

        int totalVisibleHabits = 0;

        return ListView.builder(
          itemCount: visibleHabits.length,
          itemBuilder: (ctx, index) {
            ModelHabit habit = visibleHabits[index];

            totalVisibleHabits++;

            return GestureDetector(
              onLongPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ViewHabit(
                          habit: visibleHabits[index],
                          index: index,
                        )));
              },
              onTap: () {
                setState(() {
                  if (selectedIndex[index]) {
                    completedHabits--; // Decrease count when unchecked
                  } else {
                    completedHabits++; // Increase count when checked
                  }
                  selectedIndex[index] = !selectedIndex[index]; // Toggle the habit selection
                  _saveCheckboxState(); // Save the updated state
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: selectedIndex[index]
                      ? LinearGradient(colors: [Color(0x665FE394), Color(0x66EDFFF4)])
                      : null,
                ),
                child: CheckboxListTile(
                  value: selectedIndex[index],
                  onChanged: (bool? val) {
                    setState(() {
                      if (val == true) {
                        completedHabits++; // Increase when checked
                      } else {
                        completedHabits--; // Decrease when unchecked
                      }
                      selectedIndex[index] = val ?? false; // Update the selection state
                      _saveCheckboxState(); // Save the updated state
                    });
                  },
                  title: Text(
                    habit.name,
                    style: TextStyle(
                      color: selectedIndex[index]
                          ? Color(0xFF37C871)
                          : Colors.black,
                      fontFamily: "Mine",
                      fontSize: 16,
                    ),
                  ),
                  activeColor: Color(0xFF37C871),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
