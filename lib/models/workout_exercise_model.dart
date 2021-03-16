import 'package:hive/hive.dart';

@HiveType()
class WorkoutExercise extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  String exercise;

  @HiveField(2)
  String scheme;

  WorkoutExercise(this.index, this.exercise, this.scheme);
}

