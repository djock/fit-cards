import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class AppState {
  static int workoutIndex;
  static int trainingSessionMilliseconds = 0;

  static List<WorkoutExercise> loggedExercisesList;
  static List<WorkoutExercise> activeExercisesList;
}