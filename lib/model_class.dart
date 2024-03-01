import 'package:hive/hive.dart';

part 'model_class.g.dart';

@HiveType(typeId:0)
class StudentData extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int roll_no;
  @HiveField(2)
  final String grade;
  StudentData({
    required this.name,
    required this.roll_no,
    required this.grade});
}