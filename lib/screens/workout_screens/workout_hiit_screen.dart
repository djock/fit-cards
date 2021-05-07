import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/screens/workout_screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/customize_workout_modal.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WorkoutHiitScreen extends StatefulWidget {
  @override
  _WorkoutHiitScreenState createState() => _WorkoutHiitScreenState();
}

class _WorkoutHiitScreenState extends State<WorkoutHiitScreen>
    with TickerProviderStateMixin {
  WorkoutController _workoutController;

  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  @override
  void initState() {
    _workoutController = new WorkoutController.initHiit(() {
      setState(() {});
    });

    super.initState();
  }

  Future<bool> _onBackPressed() {
    if (_workoutController.isWorkoutActive()) {
      return showDialog(
              context: context,
              builder: (context) => GeneralModal(
                    subTitle: AppLocalizations.closeWorkoutSubtitle,
                    okAction: () {
                      _onStopWorkout();
                      Get.back();
                    },
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
    if (_workoutController.isWorkoutActive()) {
      return CustomAppBar.buildWorkout(_workoutController.duration,
          timerType.timer, null, () => _onStopWorkout(), _workoutController);
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
    return _workoutController.state == workoutState.finish
        ? WorkoutEndScreen(
            workoutController: _workoutController,
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeScreen(
              topSafe: false,
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
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
                            isBlocked: _workoutController.state ==
                                    workoutState.countdown
                                ? true
                                : false,
                            type: cardType.exercise,
                            onCallback: () {
                              _onSwipeExerciseCard();
                            },
                            onSkip: () {
                              _onSkipExercise();
                            },
                            workoutController: _workoutController,
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
                            isBlocked: _workoutController.isWorkoutActive()
                                ? false
                                : true,
                            type: cardType.scheme,
                            onCallback: () {
                              _onSwipeSchemeCard();
                            },
                            workoutController: _workoutController,
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
            ),
          );
  }

  void _onStartWorkout() {
    _workoutController.startWorkout();

    _buildCountDownTimer();
  }

  void _onStopWorkout() {
    _workoutController.stopWorkout();
  }

  void _onSwipeExerciseCard() {
    if (_workoutController.state == workoutState.active) {
      if (_exerciseController.hasSkipped) {
        _schemeController.cancelCallback = true;
        _schemeController.triggerLeft();
        _exerciseController.hasSkipped = false;
      } else {
        _onStartRest(_schemeController);
      }
    }

    if (_workoutController.state == workoutState.active ||
        _workoutController.state == workoutState.countdown ||
        _workoutController.state == workoutState.rest) return;

    _onStartWorkout();
    _schemeController.triggerLeft();
  }

  void _onSwipeSchemeCard() {
    if (_workoutController.state == workoutState.active) {
      _onStartRest(_exerciseController);
    }
  }

  void _onStartRest(CardController otherController) {
    otherController.cancelCallback = true;
    otherController.triggerLeft();

    _workoutController.startRest(_exerciseController.index);
    _buildCountDownTimer();
  }

  void _onSkipExercise() {
    _exerciseController.triggerLeft();
  }

  void _onOpenFilters() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.35,
            child: CustomizeWorkoutModal(
              workoutController: _workoutController,
            ),
          );
        }).then((value) {
          setState(() { });
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
              return Scaffold(
                backgroundColor: Colors.black.withOpacity(0.5),
                body: InkWell(
                  onTap: () {
                    debugPrint('tap clock overlay');
                  },
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _workoutController.state == workoutState.countdown
                            ? AppLocalizations.getReady
                            : AppLocalizations.rest,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TimerWidget(
                        duration:
                            _workoutController.state == workoutState.countdown
                                ? 10
                                : _workoutController.settings.restTime,
                        callback: () {
                          _workoutController.setState(workoutState.active);
                          Get.back();
                        },
                        type: timerType.countdown,
                      ),
                    ],
                  )),
                ),
              );
            }),
          );
        },
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 150));
  }
}
