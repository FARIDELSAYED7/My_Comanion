import 'package:hive/hive.dart';

part 'notes.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String yournote;

  Todo({required this.title,required this.yournote});
}