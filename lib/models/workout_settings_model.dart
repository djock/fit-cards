import 'package:hive/hive.dart';

@HiveType()
class WorkoutSettingsModel {
  @HiveField(0)
  int rounds;

  @HiveField(1)
  int restTime;

  @HiveField(2)
  int workTime;

  @HiveField(3)
  bool canSkipExercise;

  @HiveField(3)
  int maxDuration;

  WorkoutSettingsModel(this.rounds, this.restTime, this.workTime, this.canSkipExercise, this.maxDuration);
}