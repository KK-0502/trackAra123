import 'package:hive_flutter/hive_flutter.dart';
part 'memoryModel.g.dart';
@HiveType(typeId: 7)
class MemoryModel{
  @HiveField(0)
  String titleGet;
  @HiveField(1)
  String dataGet;
  @HiveField(2)
  List<String>imageListGet=[];

  MemoryModel({required this.titleGet,required this.dataGet,required this.imageListGet});
}