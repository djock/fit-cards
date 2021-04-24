import 'package:hive/hive.dart';

@HiveType()
class WorkoutLogModel {
  @HiveField(0)
  int index;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int duration;

  @HiveField(3)
  int exercises;

  @HiveField(4)
  int points;

  @HiveField(5)
  String name;

  WorkoutLogModel(this.index, this.date, this.duration, this.exercises,
      this.points, this.name);
}
