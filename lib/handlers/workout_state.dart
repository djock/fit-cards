class WorkoutState {
  static bool canSkipExercise = false;
  static int restTime = 10;
  static int trainingSessionMilliseconds = 0;

  static void setRestTime(int value) {
    restTime = value;
  }

  static void setSkip(bool value) {
    canSkipExercise = value;
  }
}