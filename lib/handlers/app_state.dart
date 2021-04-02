import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';

class AppState {
  static List<WorkoutExerciseModel> loggedExercisesList;
  static List<WorkoutExerciseModel> activeExercisesList;

  static List<WorkoutLogModel> loggedWorkouts;

  static List<ExerciseModel> exercises = [];
  static List<SchemeModel> schemes = [];

  static List<ExerciseModel> cachedExercises = [];
  static List<SchemeModel> cachedSchemes = [];

  static bool tutorialFinished = false;
  static bool tutorialActive = false;

  static String userName = '';
  static bool isDarkTheme = false;
}