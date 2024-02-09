import 'package:hive/hive.dart';

@HiveType(typeId: 12)
class WorkoutExerciseModel extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  String exercise;

  @HiveField(2)
  String scheme;

  WorkoutExerciseModel(this.index, this.exercise, this.scheme);
}
