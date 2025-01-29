import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';

ValueNotifier<List<DiaryModel>>diaryNotify=ValueNotifier([]);

void addDiary(DiaryModel value)async{
 final diaryBoxDB = await Hive.openBox<DiaryModel>("Diary_db");
 diaryBoxDB.add(value);
 diaryNotify.value.add(value);
 diaryNotify.notifyListeners();
}

Future<void>getDiary()async{
  final diaryBoxDB = await Hive.openBox<DiaryModel>("Diary_db");
  diaryNotify.value.clear();
  diaryNotify.value.addAll(diaryBoxDB.values);
  diaryNotify.notifyListeners();
}

Future<void>updateDairy(int index,DiaryModel diary)async{
  final diaryBoxDB = await Hive.openBox<DiaryModel>("Diary_db");
  await diaryBoxDB.putAt(index, diary);
  diaryNotify.value[index]=diary;
  diaryNotify.notifyListeners();
}

Future<void>deleteDiary(int index)async{
  final diaryBoxDB = await Hive.openBox<DiaryModel>("Diary_db");
  await diaryBoxDB.deleteAt(index);
  diaryNotify.value.removeAt(index);
  diaryNotify.notifyListeners();
}