import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/workout_exercise_adapter.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_adapter.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHandler {
  static Box exercisesBox;
  static Box workoutsBox;

  static void init() {
    Hive.registerAdapter(WorkoutExerciseModelAdapter());
    Hive.registerAdapter(WorkoutLogModelAdapter());
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

    return true;
  }

  static void loadLoggedExercises() {
    var _box = exercisesBox.get('exercises');

    for (var item in _box) {
      AppState.loggedExercisesList.add(item);
    }
  }

  static void loadLoggedWorkouts() {
    var _box = exercisesBox.get('workouts');

    for (var item in _box) {
      AppState.loggedWorkouts.add(item);
    }
  }

  static void saveExerciseToBox() {
    exercisesBox.put('exercises', AppState.loggedExercisesList);
  }

  static void saveWorkoutToBox() {
    workoutsBox.put('workouts', AppState.loggedWorkouts);
  }
}
