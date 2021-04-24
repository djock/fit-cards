import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/firebase_database_handler.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/screens/workout_screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/customize_workout_modal.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  WorkoutController _workoutController =
      new WorkoutController(workoutType.hiit, AppState.hiitSettings);

  workoutState _state = workoutState.idle;

  PreferredSizeWidget _buildAppBar() {
    if (_state == workoutState.active || _state == workoutState.rest) {
      return CustomAppBar.buildWorkout(
        _workoutController.duration,
        timerType.timer,
        null,
        () => _onStopWorkout(),
        _workoutController
      );
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
        ? WorkoutEndScreen()
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
                        flex: 4,
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
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: FitCard(
                          list: AppState.schemes,
                          color: AppColors.schemeCardColor,
                          cardController: _schemeController,
                          isBlocked:
                              _state == workoutState.countdown ? true : false,
                          type: cardType.scheme,
                          onCallback: () {
                            _onSwipeSchemeCard();
                          },
                          isFake: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void _onStartWorkout() {
    changeState(workoutState.countdown);
    _buildCountDownTimer();
  }

  void _onStopWorkout() {
    if (_state == workoutState.countdown) {
      AppStateHandler.shuffleJson();
      changeState(workoutState.idle);
    } else {
      changeState(workoutState.finish);
    }

    if (_state == workoutState.countdown) return;

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(
        AppState.loggedWorkouts.length,
        now,
        _workoutController.duration,
        _workoutController.exercisesCount,
        _workoutController.points,
        AppLocalizations.shuffleCards);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);
  }

  void _onSwipeExerciseCard() {
    if (_state == workoutState.active) {
      if (_exerciseController.hasSkipped) {
        _schemeController.cancelCallback = true;
        _schemeController.triggerLeft();
        _exerciseController.hasSkipped = false;
      } else {
        _onSwipeSuccess(_schemeController);
      }
    }

    if (_state == workoutState.active ||
        _state == workoutState.countdown ||
        _state == workoutState.rest) return;

    _onStartWorkout();
    _schemeController.triggerLeft();
  }

  void _onSwipeSchemeCard() {
    if (_state == workoutState.active) {
      _onSwipeSuccess(_exerciseController);
    }
  }

  void _onSwipeSuccess(CardController otherController) {
    _onLogExercise();
    otherController.cancelCallback = true;
    otherController.triggerLeft();

    changeState(workoutState.rest);
    _buildCountDownTimer();
  }

  void _onLogExercise() {
    var currentExercise = new KeyValuePair(
        AppState.exercises[_exerciseController.index].name,
        AppState.schemes[_schemeController.index].name);
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));

    _workoutController.countExercise();
    _workoutController.addPoints(_exerciseController.points);
  }

  void _onSkipExercise() {
    _exerciseController.triggerLeft();
  }

  void changeState(workoutState state) {
    setState(() {
      _state = state;
    });
  }

  void _onOpenFilters() {
    FirebaseDatabaseHandler.updateLeaderBoard();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomizeWorkoutModal(
            workoutController: _workoutController,
          );
        });
  }

  void _buildCountDownTimer() {
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SafeArea(
            top: false,
            child: Builder(builder: (context) {
              return Material(
                  color: Colors.black.withOpacity(0.3),
                  child: Scaffold(
                    appBar: CustomAppBar.buildCountDown(),
                    backgroundColor: Colors.black.withOpacity(0.3),
                    body: InkWell(
                      onTap: () {
                        debugPrint('test');
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: 200.0,
                              width: 250.0,
                              color: Colors.transparent,
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(
                                    _state == workoutState.countdown
                                        ? AppLocalizations.getReady
                                        : AppLocalizations.rest,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TimerWidget(
                                    duration: _state == workoutState.countdown
                                        ? 10
                                        : _workoutController.settings.restTime,
                                    callback: () {
                                      changeState(workoutState.active);
                                      Get.back();
                                    },
                                    type: timerType.countdown,
                                  ),
                                ],
                              )))),
                    ),
                  ));
            }),
          );
        },
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 150));
  }
}
