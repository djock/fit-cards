import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/workout_exercise_adapter.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_adapter.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/models/workout_settings_adapter.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHandler {
  static Box exercisesBox;
  static Box workoutsBox;
  static Box hiitSettingsBox;
  static Box tabataSettingsBox;

  static void init() {
    Hive.registerAdapter(WorkoutExerciseModelAdapter());
    Hive.registerAdapter(WorkoutLogModelAdapter());
    Hive.registerAdapter(WorkoutSettingsModelAdapter());
  }

  static Future<bool> openHiveBoxes() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    workoutsBox = await Hive.openBox('workouts');
    AppState.loggedWorkouts = <WorkoutLogModel>[];

    if (workoutsBox.isNotEmpty) {
      loadLoggedWorkouts();
    }

    exercisesBox = await Hive.openBox('exercises');
    AppState.activeExercisesList = <WorkoutExerciseModel>[];
    AppState.loggedExercisesList = <WorkoutExerciseModel>[];

    if (exercisesBox.isNotEmpty) {
      loadLoggedExercises();
    }

    hiitSettingsBox = await Hive.openBox('hiitSettings');

    if (hiitSettingsBox.isNotEmpty) {
      loadHiitSettings();
    } else {
      AppState.hiitSettings = new WorkoutSettingsModel(8, 10, 20, true, 0);
    }
    tabataSettingsBox = await Hive.openBox('tabataSettings');

    if (tabataSettingsBox.isNotEmpty) {
      loadTabataSettings();
    } else {
      AppState.tabataSettings = new WorkoutSettingsModel(8, 10, 20, true, 0);
    }

    return true;
  }

  /// LOAD

  static void loadLoggedExercises() {
    var _box = exercisesBox.get('exercises');

    for (var item in _box) {
      AppState.loggedExercisesList.add(item);
    }
  }

  static void loadLoggedWorkouts() {
    var _box = workoutsBox.get('workouts');

    for (var item in _box) {
      AppState.loggedWorkouts.add(item);
    }
  }

  static void loadHiitSettings() {
    var _box = hiitSettingsBox.get('hiitSettings');
    AppState.hiitSettings = _box;
  }

  static void loadTabataSettings() {
    var _box = tabataSettingsBox.get('tabataSettings');
    AppState.tabataSettings = _box;
  }

  /// SAVE

  static void saveExerciseToBox() {
    exercisesBox.put('exercises', AppState.loggedExercisesList);
  }

  static void saveWorkoutToBox() {
    workoutsBox.put('workouts', AppState.loggedWorkouts);
  }

  static void saveHiitSettings() {
    hiitSettingsBox.put('hiitSettings', AppState.hiitSettings);
  }

  static void saveTabataSettings() {
    tabataSettingsBox.put('tabataSettings', AppState.tabataSettings);
  }

  static void clearAllData() {
    workoutsBox.clear();
    exercisesBox.clear();
  }
}
