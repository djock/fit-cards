enum workoutState {
  countdown,
  active,
  idle,
  finish,
  rest,
}

enum workoutType {
  freeRun,
  tabata
}

class WorkoutState {
  static bool canSkipExercise = true;
  static int restTime = 10;
  static int trainingSessionMilliseconds = 0;

  static int exercisesCount = 0;
  static int points = 0;

  static void setRestTime(int value) {
    restTime = value;
  }

  static void setSkip(bool value) {
    canSkipExercise = value;
  }
}