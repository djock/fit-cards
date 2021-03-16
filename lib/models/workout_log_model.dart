import 'package:hive/hive.dart';

@HiveType()
class WorkoutLogModel {
  @HiveField(0)
  int index;

  @HiveField(1)
  DateTime date;

  @HiveField(1)
  int duration;

  WorkoutLogModel(this.index, this.date, this.duration);
}