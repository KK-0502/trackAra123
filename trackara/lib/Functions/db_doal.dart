import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/GoalModel/goal_model.dart';

// This will be used for updating the UI when goals change
ValueNotifier<List<GoalModel>> goalModelNotify = ValueNotifier([]);

Future<void> addGoal(GoalModel value) async {
  final goalBoxDB = await Hive.openBox<GoalModel>("goal_db");
  
  // Add the goal to the database
  await goalBoxDB.add(value);
  
  // Add the goal to the list of goalModelNotify for UI updates
  goalModelNotify.value.add(value);
  
  // Notify listeners to update UI
  goalModelNotify.notifyListeners();
}

Future<void> getGoal() async {
  final goalBoxDB = await Hive.openBox<GoalModel>("goal_db");

  // Clear existing data in goalModelNotify and add fresh data from the box
  goalModelNotify.value.clear();
  goalModelNotify.value.addAll(goalBoxDB.values);
  
  // Notify listeners to update UI
  goalModelNotify.notifyListeners();
  
  print("Data loaded successfully.");
}

Future<void> updateGoal(int index, GoalModel value) async {
  final goalBoxDB = await Hive.openBox<GoalModel>("goal_db");

  // Update the goal in the Hive database at the specified index
  await goalBoxDB.putAt(index, value);
  
  // Update the goal in goalModelNotify (the in-memory list)
  goalModelNotify.value[index] = value;
  
  // Notify listeners to update UI
  goalModelNotify.notifyListeners();
}

Future<void>deleteGoal(int index)async{
 final goalBoxDB = await Hive.openBox<GoalModel>("goal_db");
  await goalBoxDB.deleteAt(index);
  goalModelNotify.value.removeAt(index);
  goalModelNotify.notifyListeners();
}

