import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:flutter/foundation.dart';

import 'app_state.dart';
import 'hive_handler.dart';

class AppStateHandler {
  static void shuffleJson() {
    AppState.exercises = List.from(AppState.cachedExercises);
    AppState.schemes = List.from(AppState.cachedSchemes);

    AppState.exercises.removeAt(0);
    AppState.schemes.removeAt(0);

    AppState.schemes.shuffle();
    AppState.exercises.shuffle();

    var dummyExercise = new ExerciseModel(name: AppLocalizations.exercise, id: -1, points: 0);
    var dummyScheme = new SchemeModel(name: AppLocalizations.scheme, id: -1, type: schemeType.reps );

    AppState.schemes.insert(0, dummyScheme);
    AppState.exercises.insert(0, dummyExercise);
  }

  static void logExercise() {
    AppState.loggedExercisesList.addAll(AppState.activeExercisesList);
    AppState.activeExercisesList.clear();
    HiveHandler.saveExerciseToBox();
  }

  static void logWorkout(WorkoutLogModel workoutLogModel) {
    AppState.loggedWorkouts.add(workoutLogModel);

    HiveHandler.saveWorkoutToBox();
  }
}