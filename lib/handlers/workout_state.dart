import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:flutter/material.dart';

import 'app_state_handler.dart';

enum workoutState {
  countdown,
  active,
  idle,
  finish,
  rest,
}

enum workoutType {
  hiit,
  tabata
}

class WorkoutState {
  static int trainingSessionMilliseconds = 0;

  static int exercisesCount = 0;
  static int points = 0;
}

class WorkoutSettings {
  int rounds = 8;
  int workTime = 20;
  int restTime = 10;
  bool canSkipExercise = true;
}

class WorkoutController {
  workoutType type;
  workoutState state;

  WorkoutSettingsModel settings;

  int points;

  WorkoutController(this.type, this.settings);

  void setSettings(WorkoutSettingsModel _settings) {
    if(type == workoutType.tabata) {
      AppState.tabataSettings = settings;
      HiveHandler.saveTabataSettings();
    } else {
      AppState.hiitSettings = settings;
      debugPrint('test2 ' + AppState.hiitSettings.restTime.toString());

      HiveHandler.saveHiitSettings();
    }

    settings = _settings;
  }

  void addPoints(int value) {
    points += value;

    AppStateHandler.savePoints(value);
  }
}