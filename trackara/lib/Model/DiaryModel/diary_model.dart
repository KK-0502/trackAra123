import 'package:hive_flutter/hive_flutter.dart';
part 'diary_model.g.dart';
@HiveType(typeId: 3)
class DiaryModel {
  @HiveField(0)
  String date;
  @HiveField(1)
  String titile;
  @HiveField(2)
  String subJect;
  @HiveField(3)
  String image;
  @HiveField(4)
  String time;
  @HiveField(5)
  String text;

  DiaryModel({
    required this.date,
    required this.titile,
    required this.subJect,
    required this.image,
    required this.time,
    required this.text,
  });
}