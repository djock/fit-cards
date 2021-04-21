import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/firebase_database_handler.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/handlers/workout_state.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/screens/workout_screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/customize_workout_modal.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WorkoutTabataScreen extends StatefulWidget {
  @override
  _WorkoutTabataScreenState createState() => _WorkoutTabataScreenState();
}

class _WorkoutTabataScreenState extends State<WorkoutTabataScreen>
    with TickerProviderStateMixin {

  WorkoutController _workoutController = new WorkoutController(workoutType.tabata, AppState.tabataSettings);

  CardController _exerciseController = new CardController();
  CountDownController _countDownController = new CountDownController();

  workoutState _state = workoutState.idle;

  PreferredSizeWidget _buildAppBar() {
    if (_state == workoutState.active ||
        _state == workoutState.rest ||
        _state == workoutState.rest && AppState.tutorialActive) {
      return TimerAppBar(
        callback: _onStopWorkout,
        isInRest: _state == workoutState.rest,
      );
    }

    if (_state == workoutState.rest) {
      return CustomAppBar.buildRest([
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.times,
              size: 35,
              color: Colors.red,
            ),
            onPressed: () {
              _onStopWorkout();
            })
      ], text: AppLocalizations.rest, iconSize: 40);
    }

    if (_state == workoutState.countdown) {
      return CustomAppBar.buildCountDown(
          text: AppLocalizations.getReady, iconSize: 40);
    }

    return CustomAppBar.buildWithActions([
      IconButton(
          icon: FaIcon(
            FontAwesomeIcons.slidersH,
            color: Get.isDarkMode
                ? Theme.of(Get.context).accentColor
                : Theme.of(Get.context).primaryColorDark,
            size: 18,
          ),
          onPressed: () {
            _onOpenFilters();
          })
    ], iconSize: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return _state == workoutState.finish
        ? WorkoutEndScreen(
      callback: _onEndWorkout,
    )
        : SafeScreen(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.91,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('round 1 / 8'),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: FitCard(
                    list: AppState.exercises,
                    color: AppColors.exerciseCardColor,
                    cardController: _exerciseController,
                    isBlocked:
                    _state == workoutState.countdown ? true : false,
                    type: cardType.exercise,
                    onCallback: () {
                      _onSwipeExerciseCard();
                    },
                    onSkip: () {
                      _onSkipExercise();
                    },
                    isFake: false,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
          _state == workoutState.countdown ||
              _state == workoutState.rest && !AppState.tutorialActive
              ? Align(
            alignment: Alignment.center,
            child: Container(
              color: AppTheme.countDownTimerColor(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: _buildCountDownTimer(),
              ),
            ),
          )
              : SizedBox(
            height: 0,
          )
        ],
      ),
    );
  }

  bool _countDownPaused = false;

  Widget _buildCountDownTimer() {
    var timerDuration = AppState.tutorialActive
        ? _state == workoutState.rest
        ? 0
        : _workoutController.settings.restTime
        : _state == workoutState.countdown
        ? 10
        : _workoutController.settings.restTime;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: InkWell(
            onTap: () {
              if (_state == workoutState.countdown) {
                if (_countDownPaused) {
                  _countDownController.resume();
                  setState(() {
                    _countDownPaused = false;
                  });
                } else {
                  _countDownController.pause();
                  setState(() {
                    _countDownPaused = true;
                  });
                }
              }
            },
            child: CircularCountDownTimer(
              duration: timerDuration,
              initialDuration: 0,
              controller: _countDownController,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 3,
              ringColor: Colors.red.withOpacity(0.65),
              ringGradient: null,
              fillColor: Colors.red,
              fillGradient: null,
              backgroundColor: Colors.purple[500].withOpacity(0),
              backgroundGradient: null,
              strokeWidth: 12.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 50.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onStart: () {
              },
              onComplete: () {
                if (_state == workoutState.countdown)
                  changeState(workoutState.active);

                if (_state == workoutState.rest)
                  changeState(workoutState.active);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onStartWorkout() {
    changeState(workoutState.countdown);
  }

  void _onStopWorkout() {
    if (AppState.tutorialActive) {
      changeState(workoutState.finish);
      return;
    }

    if (_state == workoutState.countdown) {
      AppStateHandler.shuffleJson();
      changeState(workoutState.idle);
    } else {
      changeState(workoutState.finish);
    }

    if (_state == workoutState.countdown) return;

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(AppState.loggedWorkouts.length,
        now, WorkoutState.trainingSessionMilliseconds, WorkoutState.exercisesCount, WorkoutState.points);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);
  }

  void _onSwipeExerciseCard() {
    if (_state == workoutState.active) {
      if (_exerciseController.hasSkipped) {
        _exerciseController.hasSkipped = false;
      } else {
      }

      _onSwipeSuccess();
    }
    if (_state == workoutState.active ||
        _state == workoutState.countdown ||
        _state == workoutState.rest) return;

    _onStartWorkout();
  }

  void _onSwipeSuccess() {
    _onLogExercise();
    changeState(workoutState.rest);
  }

  void _onLogExercise() {
    if(!AppState.tutorialActive) {
      var currentExercise = new KeyValuePair(
          AppState.exercises[_exerciseController.index].name,
          _workoutController.settings.restTime.toString());
      AppState.activeExercisesList.add(new WorkoutExerciseModel(
          AppState.loggedWorkouts.length,
          currentExercise.key,
          currentExercise.value));


      WorkoutState.exercisesCount++;
      _workoutController.addPoints(_exerciseController.points);
    }
  }

  void _onSkipExercise() {
    _exerciseController.triggerLeft();
  }

  void changeState(workoutState state) {
    setState(() {
      _state = state;
    });
  }

  void _onEndWorkout() {
    UserPreferencesHandler.markTutorialAsFinished();
  }

  void _onOpenFilters() {
    FirebaseDatabaseHandler.updateLeaderBoard();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomizeWorkoutModal(workoutController: _workoutController,);
        });
  }
}
