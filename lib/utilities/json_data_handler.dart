import 'dart:convert';

import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class JsonDataHandler {
  static List<ExerciseModel> exercises = new List<ExerciseModel>();
  static List<SchemeModel> schemes = new List<SchemeModel>();

  static Future<String> loadJsonFile(String json) {
    return rootBundle.loadString('assets/$json.json');
  }

  static Future<bool> loadAppData() async {
    await loadJsonFile('exercises').then((value) {
      exercises = ExerciseModel.fromJsonList(jsonDecode(value));

      exercises.shuffle();
    });

    await loadJsonFile('schemes').then((value) {
      schemes = SchemeModel.fromJsonList(jsonDecode(value));

      schemes.shuffle();
    });

    return true;
  }
}