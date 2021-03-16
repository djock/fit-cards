import 'package:hive/hive.dart';

@HiveType()
class WorkoutExerciseModel extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  String exercise;

  @HiveField(2)
  String scheme;

  WorkoutExerciseModel(this.index, this.exercise, this.scheme);
}

