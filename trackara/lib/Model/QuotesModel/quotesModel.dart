import 'package:hive_flutter/hive_flutter.dart';
part 'quotesModel.g.dart';
@HiveType(typeId: 5)
class Quotesmodel {
  @HiveField(0)
  String image;
  Quotesmodel({required this.image});
}