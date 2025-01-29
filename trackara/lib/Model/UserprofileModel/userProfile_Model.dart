import 'package:hive_flutter/hive_flutter.dart';
part 'userProfile_Model.g.dart';
@HiveType(typeId: 4)
class UserProfileModel{
  @HiveField(0)
  String name;
  @HiveField(1)
  int? age;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? hobbie;
  @HiveField(4)
  String? image;

  UserProfileModel({required this.name,this.age,this.email,this.hobbie,this.image});
}