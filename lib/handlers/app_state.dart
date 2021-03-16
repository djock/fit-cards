import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:hive/hive.dart';

class AppState {
  static int trainingSessionMilliseconds = 0;
  static Box workoutsLogBox;

  static List<WorkoutLogModel> workoutsLog;
  static List<KeyValuePair> activeWorkoutExercises = <KeyValuePair>[];

  static void saveWorkoutsLog(List<WorkoutLogModel> workoutsLog) {
    workoutsLogBox.put('workoutsLog', workoutsLog);
  }

  static void loadWorkoutsLog() {
    var _box = workoutsLogBox.get('workoutsLog');

    for (var item in _box) {
      workoutsLog.add(item);
    }
  }
}