import 'package:hive_flutter/hive_flutter.dart';
part 'goal_model.g.dart';
@HiveType(typeId: 2)
class GoalModel{
  @HiveField(0)
  String name;
  @HiveField(1)
  int amount;
  @HiveField(2)
  String discription;
  @HiveField(3)
  String stratDate;
  @HiveField(4)
  String endDate;
  @HiveField(5)
  String image;  ///hive 6 ,int?   value,
  @HiveField(6)
  int? addValue;
  GoalModel({
  required this.name,
  required this.amount,
  required this.discription,
  required this.stratDate,
  required this.endDate,
  required this.image,
  this.addValue=0
  });// this.value=0
}