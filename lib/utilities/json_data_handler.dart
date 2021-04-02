import 'dart:convert';

import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class JsonDataHandler {
  static Future<String> loadJsonFile(String json) {
    return rootBundle.loadString('assets/$json.json');
  }

  static Future<bool> loadAppData() async {
    await loadJsonFile('exercises').then((value) {
      AppState.cachedExercises = ExerciseModel.fromJsonList(jsonDecode(value));
    });

    await loadJsonFile('schemes').then((value) {
      AppState.cachedSchemes = SchemeModel.fromJsonList(jsonDecode(value));
    });

    AppStateHandler.shuffleJson();

    return true;
  }
}