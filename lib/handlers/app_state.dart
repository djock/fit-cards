import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';

class AppState {
  static int trainingSessionMilliseconds = 0;

  static List<WorkoutExerciseModel> loggedExercisesList;
  static List<WorkoutExerciseModel> activeExercisesList;

  static List<WorkoutLogModel> loggedWorkouts;

  static void logExercise() {
    AppState.loggedExercisesList.addAll(AppState.activeExercisesList);
    AppState.activeExercisesList.clear();
    HiveHandler.saveExerciseToBox();
  }

  static void logWorkout(WorkoutLogModel workoutLogModel) {
    loggedWorkouts.add(workoutLogModel);

    HiveHandler.saveWorkoutToBox();
  }
}