import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/screens/how_it_works_overlay.dart';
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

class WorkoutTabataScreen extends StatefulWidget {
  @override
  _WorkoutTabataScreenState createState() => _WorkoutTabataScreenState();
}

class _WorkoutTabataScreenState extends State<WorkoutTabataScreen>
    with TickerProviderStateMixin {
  WorkoutController? _workoutController;
  CardController _exerciseController = new CardController();

  @override
  void initState() {
    _workoutController = new WorkoutController.initTabata(() {
      setState(() {});
    });

    _checkHowItWorks();

    super.initState();
  }

  void _checkHowItWorks() async {
    while (this.mounted) {
      await Future.delayed(Duration(seconds: 1));
      if (!AppState.sawHowItWorksTabata) {
        var texts = [
          AppLocalizations.howItWorksTabata1,
          AppLocalizations.howItWorksTabata2,
          AppLocalizations.howItWorksTabata3,
          AppLocalizations.howItWorksTabata4,
        ];

        HowItWorksOverlay.build(texts);
        UserPreferencesHandler.saveSawHowItWorksTabata();
      }
    }
  }

  Future<bool> _onBackPressed() async {
    if (_workoutController!.isWorkoutActive()) {
      await showDialog(
          context: context,
          builder: (context) => GeneralModal(
                subTitle: AppLocalizations.closeWorkoutSubtitle,
                okAction: () => _onStopWorkout(),
                cancelAction: () => Get.back(),
                okActionText: AppLocalizations.close,
                cancelActionText: AppLocalizations.cancel,
                title: '',
              ));
    } else {
      Get.back();
      Get.back();
    }

    return true;
  }

  PreferredSizeWidget _buildAppBar() {
    if (_workoutController!.state == workoutState.countdown) {
      return CustomAppBar.buildWorkout(
        10,
        timerType.countdown,
        () => _setState(),
        () => Get.back(),
        _workoutController!,
      );
    }

    if (_workoutController!.isWorkoutActive()) {
      _workoutController!.addDuration(
          _workoutController!.state == workoutState.active
              ? _workoutController!.settings.workTime
              : _workoutController!.settings.restTime);

      return CustomAppBar.buildWorkout(
          _workoutController!.state == workoutState.active
              ? _workoutController!.settings.workTime
              : _workoutController!.settings.restTime,
          timerType.countdown,
          () => _setState(),
          () => _onStopWorkout(),
          _workoutController!);
    }

    return CustomAppBar.buildWithActions([
      IconButton(
          icon: FaIcon(
            FontAwesomeIcons.slidersH,
            color: Theme.of(Get.context!).primaryColorDark,
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
      if (_workoutController!.state == workoutState.countdown) {
        _workoutController!.setState(workoutState.active);
        return;
      }

      if (_workoutController!.state == workoutState.active) {
        if (_workoutController!.exercisesCount + 1 ==
            _workoutController!.settings.rounds) {
          _onStopWorkout();
          return;
        }

        _exerciseController.triggerLeft();
        _onStartRest();
        return;
      }

      if (_workoutController!.state == workoutState.rest) {
        _workoutController!.setState(workoutState.active);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _workoutController!.state == workoutState.finish
        ? WorkoutEndScreen(
            workoutController: _workoutController!,
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeScreen(
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.91,
                    child: Column(
                      children: [
                        _workoutController!.isWorkoutActive()
                            ? Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    '${AppLocalizations.round} ${_workoutController!.exercisesCount + 1} / ${_workoutController!.settings.rounds}',
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
                                        '${_workoutController!.settings.rounds}x',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                      Text(
                                        '${_workoutController!.settings.workTime}/',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                      Text(
                                        '${_workoutController!.settings.restTime}',
                                        style: AppTheme.textAccentBold30(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        Expanded(
                          flex: 6,
                          child: FitCard(
                            list: _workoutController!.exercises,
                            color: AppColors.exerciseCardColor,
                            cardController: _exerciseController,
                            isBlocked:
                                _workoutController!.state == workoutState.idle
                                    ? false
                                    : true,
                            type: cardType.exercise,
                            onCallback: () {
                              _onSwipeExerciseCard();
                            },
                            onSkip: null,
                            workoutController: _workoutController!,
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
              topSafe: false,
            ),
          );
  }

  void _onStartWorkout() {
    _workoutController!.setState(workoutState.countdown);
  }

  void _onStopWorkout() {
    _workoutController!.stopWorkout();
  }

  void _onSwipeExerciseCard() {
    if (_workoutController!.state == workoutState.active) {
      if (_exerciseController.hasSkipped) {
        _exerciseController.hasSkipped = false;
      } else {
        _onStartRest();
      }
    }

    if (_workoutController!.state == workoutState.active ||
        _workoutController!.state == workoutState.countdown ||
        _workoutController!.state == workoutState.rest) return;

    _onStartWorkout();
  }

  void _onStartRest() {
    _workoutController!.startRest(_exerciseController.index);
  }

  void _onOpenFilters() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: CustomizeWorkoutModal(
              workoutController: _workoutController!,
            ),
          );
        }).then((value) {
      if (_workoutController!.exercises.first.name !=
          AppLocalizations.exercise) {
        var dummyExercise = new ExerciseModel(
            name: AppLocalizations.exercise, id: -1, points: 0);
        _workoutController!.exercises.insert(0, dummyExercise);

        setState(() {});
      }
    });
  }
}
