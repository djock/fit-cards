import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';

class AppState {
  static int trainingSessionMilliseconds = 0;

  static List<WorkoutExerciseModel> loggedExercisesList;
  static List<WorkoutExerciseModel> activeExercisesList;

  static List<WorkoutLogModel> loggedWorkouts;

  static List<ExerciseModel> exercises = new List<ExerciseModel>();
  static List<SchemeModel> schemes = new List<SchemeModel>();
}