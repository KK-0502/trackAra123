import 'package:hive_flutter/hive_flutter.dart';
part 'habit_model.g.dart';
@HiveType(typeId: 1)
class ModelHabit {
  @HiveField(0)
  int?id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String selectedTime;
  @HiveField(3)
   List<String> selectedDays = [];
   @HiveField(4)
  final String? remider;
  ModelHabit({required this.name,required this.selectedDays,this.remider,required this.selectedTime,this.id});
  }

