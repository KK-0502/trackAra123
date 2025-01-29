import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';

ValueNotifier<List<ModelHabit>>addHabitNotify=ValueNotifier([]);

Future<void> addHabit(ModelHabit value)async{
  final habitDb=await Hive.openBox<ModelHabit>('habit_db');
  habitDb.add(value);
  addHabitNotify.value.add(value);
  addHabitNotify.notifyListeners();
}

Future<void>getHabit()async{
  final habitDb=await Hive.openBox<ModelHabit>('habit_db');
  addHabitNotify.value.clear();
  addHabitNotify.value.addAll(habitDb.values);
  addHabitNotify.notifyListeners();
}

Future<void>deleteHabit(int index)async{
  final habitDb=await Hive.openBox<ModelHabit>('habit_db');
  await habitDb.deleteAt(index);
  addHabitNotify.value.removeAt(index);
  addHabitNotify.notifyListeners();
}

Future<void>updateHabitNew(int index,ModelHabit value)async{
  final habitDb=await Hive.openBox<ModelHabit>('habit_db');
  await habitDb.putAt(index, value);
  addHabitNotify.value[index]=value;
  addHabitNotify.notifyListeners();
}

