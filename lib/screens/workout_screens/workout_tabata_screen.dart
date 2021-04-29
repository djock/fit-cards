import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/screens/workout_screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/customize_workout_modal.dart';
import 'package:fitcards/widgets/exercises_list_modal.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WorkoutTabataScreen extends StatefulWidget {
  @override
  _WorkoutTabataScreenState createState() => _WorkoutTabataScreenState();
}

class _WorkoutTabataScreenState extends State<WorkoutTabataScreen>
    with TickerProviderStateMixin {
  WorkoutController _workoutController =
      new WorkoutController(workoutType.tabata, AppState.tabataSettings);

  CardController _exerciseController = new CardController();

  workoutState _state = workoutState.idle;

  @override
  void initState() {
    _setExercises();

    super.initState();
  }

  void _setExercises() {
    _workoutController.setExercises(AppState.exercises);
  }

  Future<bool> _onBackPressed() {
    if (_state == workoutState.active || _state == workoutState.rest) {
      return showDialog(
              context: context,
              builder: (context) => GeneralModal(
                    subTitle: AppLocalizations.closeWorkoutSubtitle,
                    okAction: () => _onStopWorkout(),
                    cancelAction: () => Get.back(),
                    okActionText: AppLocalizations.close,
                    cancelActionText: AppLocalizations.cancel,
                  )) ??
          false;
    } else {
      Get.back();
      Get.back();
    }
  }

  PreferredSizeWidget _buildAppBar() {
    if (_state == workoutState.countdown) {
      return CustomAppBar.buildWorkout(
        10,
        timerType.countdown,
        () => _setState(),
        () => Get.back(),
        _workoutController,
      );
    }

    if (_state == workoutState.active || _state == workoutState.rest) {
      _workoutController.addDuration(_state == workoutState.active
          ? _workoutController.settings.workTime
          : _workoutController.settings.restTime);

      return CustomAppBar.buildWorkout(
          _state == workoutState.active
              ? _workoutController.settings.workTime
              : _workoutController.settings.restTime,
          timerType.countdown,
          () => _setState(),
          () => _onStopWorkout(),
          _workoutController);
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

  void _setState() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      if (_state == workoutState.countdown) {
        changeState(workoutState.active);
        return;
      }

      if (_state == workoutState.active) {
        if (_workoutController.exercisesCount + 1 ==
            _workoutController.settings.rounds) {
          _onStopWorkout();
          return;
        }

        _exerciseController.triggerLeft();
        _onSwipeSuccess();
        return;
      }

      if (_state == workoutState.rest) {
        changeState(workoutState.active);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _state == workoutState.finish
        ? WorkoutEndScreen()
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeScreen(
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.91,
                    child: Column(
                      children: [
                        _state == workoutState.active ||
                                _state == workoutState.rest
                            ? Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    '${AppLocalizations.round} ${_workoutController.exercisesCount + 1} / ${_workoutController.settings.rounds}',
                                    style: AppTheme.textAccentBold30(),
                                  ),
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${_workoutController.settings.rounds}x',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                      Text(
                                        '${_workoutController.settings.workTime}/',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                      Text(
                                        '${_workoutController.settings.restTime}',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        Expanded(
                          flex: 6,
                          child: FitCard(
                            list: _workoutController.exercises,
                            color: AppColors.exerciseCardColor,
                            cardController: _exerciseController,
                            isBlocked:
                                _state == workoutState.idle ? false : true,
                            type: cardType.exercise,
                            onCallback: () {
                              _onSwipeExerciseCard();
                            },
                            onSkip: null,
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
                ],
              ),
            ),
          );
  }

  void _onStartWorkout() {
    changeState(workoutState.countdown);
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
    debugPrint('save ' + _workoutController.duration.toString());
    var currentWorkout = new WorkoutLogModel(
        AppState.loggedWorkouts.length,
        now,
        _workoutController.duration,
        _workoutController.exercisesCount,
        _workoutController.points,
        AppLocalizations.tabata);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);
  }

  void _onSwipeExerciseCard() {
    if (_state == workoutState.active) {
      if (_exerciseController.hasSkipped) {
        _exerciseController.hasSkipped = false;
      } else {
        _onSwipeSuccess();
      }
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
    var currentExercise = new KeyValuePair(
        _workoutController.exercises[_exerciseController.index].name,
        _workoutController.settings.restTime.toString());
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));

    _workoutController.countExercise();
    _workoutController.addPoints(_exerciseController.points);
  }

  void changeState(workoutState state) {
    setState(() {
      _state = state;
    });
  }

  void _onOpenFilters() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomizeWorkoutModal(
            workoutController: _workoutController,
            callback: () => setState(() {}),
          );
        });
  }

  void _openExercisesList() {
    showGeneralDialog(
        context: Get.context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return ExercisesListModal(
            workoutController: _workoutController,
            callback: () => setState(() {
              var dummyExercise = new ExerciseModel(
                  name: AppLocalizations.exercise, id: -1, points: 0);
              _workoutController.exercises.insert(0, dummyExercise);
            }),
          );
        });
  }
}
