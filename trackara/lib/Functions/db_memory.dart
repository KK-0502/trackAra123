import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/MemoryModel/memoryModel.dart';


ValueNotifier<List<MemoryModel>>memoryNotify=ValueNotifier([]);

Future<void>addImage(MemoryModel value)async{
 final memoryBoxDb= await Hive.openBox<MemoryModel>("memory_db");
 memoryBoxDb.add(value);
 memoryNotify.value.add(value);
 memoryNotify.notifyListeners();
}
Future<void>getImage()async{
  final memoryBoxDb= await Hive.openBox<MemoryModel>("memory_db");
  memoryNotify.value.clear();
  memoryNotify.value.addAll(memoryBoxDb.values);
  memoryNotify.notifyListeners();
}

Future<void>updateMemory(int index,MemoryModel diary)async{
  final memoryBoxDb= await Hive.openBox<MemoryModel>("memory_db");
  await memoryBoxDb.putAt(index, diary);
  memoryNotify.value[index]=diary;
  memoryNotify.notifyListeners();
}

Future<void>deleteMemory(int index)async{
  final memoryBoxDb= await Hive.openBox<MemoryModel>("memory_db");
  await memoryBoxDb.deleteAt(index);
  memoryNotify.value.removeAt(index);
  memoryNotify.notifyListeners();
}