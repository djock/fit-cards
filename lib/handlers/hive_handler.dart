import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/workout_exercise_adapter.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHandler {
  static Box workoutsLogBox;
  static Box workoutsIndexBox;

  static void init() {
    Hive.registerAdapter(WorkoutExerciseModelAdapter());
  }

  static Future<bool> openHiveBoxes() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    workoutsIndexBox = await Hive.openBox('workoutIndex');
    AppState.workoutIndex = 0;

    if (workoutsIndexBox.isNotEmpty) {
      loadWorkoutIndex();
    }

    workoutsLogBox = await Hive.openBox('workoutsLog');
    AppState.activeExercisesList = <WorkoutExercise>[];
    AppState.loggedExercisesList = <WorkoutExercise>[];

    if (workoutsLogBox.isNotEmpty) {
      loadWorkoutsLog();
    }

    return true;
  }

  static void loadWorkoutsLog() {
    var _box = workoutsLogBox.get('workoutsLog');

    for (var item in _box) {
      AppState.loggedExercisesList.add(item);
    }
  }

  static void loadWorkoutIndex() {
    var existingIndex = workoutsIndexBox.get('workoutIndex');
    AppState.workoutIndex = existingIndex + 1;
  }

  static void logExercises() {
    AppState.loggedExercisesList.addAll(AppState.activeExercisesList);
    AppState.activeExercisesList.clear();

    workoutsLogBox.put('workoutsLog', AppState.loggedExercisesList);
  }

  static void logWorkoutIndex() {
    workoutsIndexBox.put('workoutIndex', AppState.workoutIndex);
    AppState.workoutIndex++;
  }
}
