import 'package:fitcards/handlers/analytics_handler.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';

import 'app_state_handler.dart';

enum workoutState {
  countdown,
  active,
  idle,
  finish,
  rest,
}

enum workoutType { hiit, tabata }

class WorkoutSettings {
  int rounds = 8;
  int workTime = 20;
  int restTime = 10;
  bool canSkipExercise = true;
}

class WorkoutController {
  List<ExerciseModel> exercises;
  List<SchemeModel>? schemes;

  workoutType type;
  workoutState state;

  WorkoutSettingsModel settings;
  Function updateScreen;

  int points = 0;
  int exercisesCount = 0;

  int duration = 0;

  WorkoutController(this.type, this.settings, this.state, this.exercises,
      this.schemes, this.updateScreen);

  factory WorkoutController.initHiit(Function callback) {
    return new WorkoutController(workoutType.hiit, AppState.hiitSettings!,
        workoutState.idle, AppState.exercises, AppState.schemes, callback);
  }

  factory WorkoutController.initTabata(Function callback) {
    return new WorkoutController(workoutType.tabata, AppState.tabataSettings!,
        workoutState.idle, AppState.exercises, null, callback);
  }

  void setSettings(WorkoutSettingsModel _settings) {
    if (type == workoutType.tabata) {
      HiveHandler.saveTabataSettings();
    } else {
      AppState.hiitSettings = settings;
      HiveHandler.saveHiitSettings();
    }

    settings = _settings;
  }

  void setExercises(List<ExerciseModel> value) {
    exercises = value;
  }

  void setSchemes(List<SchemeModel> value) {
    schemes = value;
  }

  void countExercise() {
    exercisesCount++;
  }

  void addPoints(int value) {
    points += value;

    AppStateHandler.savePoints(value);
  }

  void addDuration(int value) {
    duration += value;
  }

  void setDuration(int value) {
    duration = value;
  }

  void logExercise(int index) {
    var exerciseName = exercises[index].name;
    var schemeName = type == workoutType.hiit
        ? schemes![index].name
        : settings.restTime.toString();

    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length, exerciseName, schemeName));

    countExercise();
  }

  void startWorkout() {
    AnalyticsHandler.logStartWorkout(type);
    setState(workoutState.countdown);
  }

  void setState(workoutState value) {
    state = value;
    updateScreen();
  }

  bool isWorkoutActive() {
    return state == workoutState.active || state == workoutState.rest;
  }

  void stopWorkout() {
    AnalyticsHandler.logStopWorkout(type, points);

    if (state == workoutState.countdown) {
      AppStateHandler.shuffleJson();
      setState(workoutState.idle);
    } else {
      setState(workoutState.finish);
    }

    if (state == workoutState.countdown || exercisesCount == 0) return;

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(
        AppState.loggedWorkouts.length,
        now,
        duration,
        exercisesCount,
        points,
        type == workoutType.hiit
            ? AppLocalizations.hiit
            : AppLocalizations.tabata);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);
  }

  void startRest(int index) {
    addPoints(exercises[index].points!);
    logExercise(index);
    setState(workoutState.rest);
  }
}
