import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/workout_log_adapter.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHandler {
  static void init() {
    Hive.registerAdapter(WorkoutLogModelAdapter());
    Hive.registerAdapter(KeyValuePairAdapter());
  }

  static Future<bool> openWorkoutsLogBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    AppState.workoutsLogBox = await Hive.openBox('workoutsLog');
    AppState.workoutsLog = <WorkoutLogModel>[];

    if (AppState.workoutsLogBox.isEmpty) {
      debugPrint('nothing yet');
      return false;
    } else {
      loadWorkoutsLog();
      return true;
    }
  }

  static void loadWorkoutsLog() {
    var _box = AppState.workoutsLogBox.get('workoutsLog');

    for (var item in _box) {
      AppState.workoutsLog.add(item);
    }

    for(var item in AppState.workoutsLog) {
    }
  }

  static void saveWorkoutsLogToBox() {
    AppState.workoutsLogBox.put('workoutsLog', AppState.workoutsLog);
  }
}
