import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum workoutState {
  countdown,
  active,
  idle,
  finish,
}

class CardsScreen extends StatefulWidget {
  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen>
    with TickerProviderStateMixin {
  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  CountDownController _countDownController = new CountDownController();

  workoutState _state = workoutState.idle;

  TutorialCoachMark _tutorialCoachMark;

  @override
  void initState() {
    if (!AppState.tutorialFinished && !AppState.tutorialActive) {
      _initializeIdleTargets();
      _initializeActiveTargets();

      _startTutorial();
    }

    super.initState();
  }

  Future<Null> _startTutorial() async {
    const timeOut = const Duration(milliseconds: 500);
    new Timer(timeOut, () {
      setState(() {
        _showIdleTutorial();
      });
    });
  }

  Future<Null> _delayTutorialNext() async {
    if (AppState.tutorialActive) {
      const timeOut = const Duration(seconds: 4);
      new Timer(timeOut, () {
        if (AppState.tutorialActive && _tutorialCoachMark != null) _tutorialCoachMark.finish();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _state == workoutState.finish
        ? WorkoutEndScreen(
            callback: _onEndWorkout,
          )
        : SafeScreen(
            appBar: _state == workoutState.active
                ? TimerAppBar(
                    key: _timerKey,
                    callback: _onStopWorkout,
                  )
                : CustomAppBar.buildWithActions(context, [
                    IconButton(icon: Icon(Icons.graphic_eq, color: Get.isDarkMode ? Theme.of(Get.context).accentColor : Theme.of(Get.context).primaryColorDark,) , onPressed: null)
                  ]),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  height: MediaQuery.of(context).size.height * 0.91,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: FitCard(
                          key: _exerciseKey,
                          list: AppState.exercises,
                          color: Colors.white,
                          cardController: _exerciseController,
                          isBlocked: _state == workoutState.active ? false : true,
                          type: cardType.exercise,
                          callback: () {
                            if(_state == workoutState.active) {
                              _schemeController.triggerLeft();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: FitCard(
                          key: _schemeKey,
                          list: AppState.schemes,
                          color: Colors.white,
                          cardController: _schemeController,
                          isBlocked: true,
                          type: cardType.scheme,
                          callback: () {

                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: _state == workoutState.active
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.center,
                          children: [
                            _buildStartButton(),
//                            _state == workoutState.active
//                                ? _buildNextButton()
//                                : SizedBox(
//                                    width: 0,
//                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _state == workoutState.countdown
                    ? Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: CircularCountDownTimer(
                            key: _startCountDownKey,
                            duration: 5,
                            initialDuration: 0,
                            controller: _countDownController,
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 3,
                            ringColor: AppColors.accentColor.withOpacity(0.5),
                            ringGradient: null,
                            fillColor: AppColors.accentColor,
                            fillGradient: null,
                            backgroundColor: Colors.purple[500].withOpacity(0),
                            backgroundGradient: null,
                            strokeWidth: 12.0,
                            strokeCap: StrokeCap.round,
                            textStyle: TextStyle(
                                fontSize: 50.0,
                                color: AppColors.accentColor,
                                fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.S,
                            isReverse: true,
                            isReverseAnimation: false,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              _delayTutorialNext();
                              print('Countdown Started');
                            },
                            onComplete: () {
                              changeState(workoutState.active);
                              _onSwipeCards();
                              print('Countdown Ended');
                            },
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

//  Widget _buildNextButton() {
//    return CustomButton(
//      key: _nextKey,
//      buttonColor: AppColors.accentColor,
//      onPressed: () {
//        var currentExercise = new KeyValuePair(
//            AppState.exercises[_exerciseController.index].name,
//            AppState.schemes[_schemeController.index].name);
//        AppState.activeExercisesList.add(new WorkoutExerciseModel(
//            AppState.loggedWorkouts.length,
//            currentExercise.key,
//            currentExercise.value));
//
//        _onSwipeCards();
//      },
//      textColor: AppColors.canvasColorLight,
//      isOutline: false,
//      isRequest: false,
//      buttonText: AppLocalizations.next,
//    );
//  }

  Widget _buildStartButton() {
    return CustomButton(
      key: _state == workoutState.active ? _stopKey : _startKey,
      buttonColor: AppColors.accentColor,
      onPressed: () {
        if (_state == workoutState.active || _state == workoutState.countdown) {
          _onStopWorkout();
        } else {
          _onStartWorkout();
        }
      },
      textColor: AppColors.canvasColorLight,
      isOutline: false,
      isRequest: false,
      buttonText:
          _state == workoutState.active || _state == workoutState.countdown
              ? AppLocalizations.stop
              : AppLocalizations.start,
    );
  }

  void _onStartWorkout() {
    changeState(workoutState.countdown);
  }

  void _onStopWorkout() {
    if (AppState.tutorialActive) _tutorialCoachMark.finish();

    if (_state == workoutState.countdown) {
      changeState(workoutState.idle);
    } else {
      changeState(workoutState.finish);
    }

    var currentExercise = new KeyValuePair(
        AppState.exercises[_exerciseController.index].name,
        AppState.schemes[_schemeController.index].name);
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(AppState.loggedWorkouts.length,
        now, AppState.trainingSessionMilliseconds);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);
  }

  void _onSwipeCards() {
    var exerciseRandom = new Random();
    if (exerciseRandom.nextBool()) {
      _exerciseController.triggerLeft();
      _schemeController.triggerLeft();
    } else {
      _exerciseController.triggerRight();
      _schemeController.triggerRight();
    }
  }

  void changeState(workoutState state) {
    if (AppState.tutorialActive && state == workoutState.active) {
      _showActiveTutorial();
    }

    setState(() {
      _state = state;
    });
  }

  void _showIdleTutorial() {
    AppState.tutorialActive = true;

    _tutorialCoachMark = TutorialCoachMark(
      context,
      targets: _idleTargets,
      colorShadow: Colors.red,
      textSkip: AppLocalizations.skip,
      paddingFocus: 10,
      opacityShadow: 0.9,
      onFinish: () {},
      onClickTarget: (target) {
        if (target.identify == 'startButton') {
          _onStartWorkout();
        }
      },
      onSkip: () {
        UserPreferencesHandler.markTutorialAsFinished();
      },
      onClickOverlay: (target) {
        _tutorialCoachMark.next();
      },
    )..show();
  }

  void _showActiveTutorial() {
    if (!AppState.tutorialActive) AppState.tutorialActive = false;

    _tutorialCoachMark = TutorialCoachMark(
      context,
      targets: _activeTargets,
      colorShadow: Colors.red,
      textSkip: AppLocalizations.skip,
      paddingFocus: 10,
      opacityShadow: 0.9,
      onFinish: () {},
      onClickTarget: (target) {
        _tutorialCoachMark.next();
        if (target.identify == 'stopButton') {
          _onEndWorkout();
          _onStopWorkout();
        }

        if(target.identify == 'swipeCard') {
          _exerciseController.triggerLeft();
        }
      },
      onSkip: () {
        _onEndWorkout();
      },
      onClickOverlay: (target) {
        _tutorialCoachMark.next();
      },
    )..show();
  }

  void _onEndWorkout() {
    UserPreferencesHandler.markTutorialAsFinished();
  }

  ///::::::::::::::::::::::::::::::::::::::\\\
  ///:::::::::::::: TUTORIAL ::::::::::::::\\\
  ///::::::::::::::::::::::::::::::::::::::\\\

  GlobalKey _exerciseKey = GlobalKey();
  GlobalKey _schemeKey = GlobalKey();
  GlobalKey _startKey = GlobalKey();
  GlobalKey _startCountDownKey = GlobalKey();
  GlobalKey _timerKey = GlobalKey();
  GlobalKey _nextKey = GlobalKey();
  GlobalKey _stopKey = GlobalKey();

  List<TargetFocus> _activeTargets = [];
  List<TargetFocus> _idleTargets = [];

  void _initializeActiveTargets() {
    _activeTargets.add(
      _targetFocusBuilder(_timerKey, ContentAlign.bottom, ShapeLightFocus.RRect,
          '', AppLocalizations.tutorialTimerDescription,
          textAlign: TextAlign.center),
    );

    _activeTargets.add(
      _targetFocusBuilder(_exerciseKey, ContentAlign.bottom, ShapeLightFocus.RRect, '',
          AppLocalizations.tutorialSwipeExerciseCard,
          identity: 'swipeCard'),
    );

    _activeTargets.add(
      _targetFocusBuilder(_stopKey, ContentAlign.top, ShapeLightFocus.RRect, '',
          AppLocalizations.tutorialStopButtonDescription,
          identity: 'stopButton'),
    );
  }

  _initializeIdleTargets() {
    _idleTargets.add(
      _targetFocusBuilder(
          _exerciseKey,
          ContentAlign.bottom,
          ShapeLightFocus.RRect,
          AppLocalizations.tutorialExerciseCardTitle,
          AppLocalizations.tutorialExerciseCardDescription),
    );

    _idleTargets.add(
      _targetFocusBuilder(
          _schemeKey,
          ContentAlign.top,
          ShapeLightFocus.RRect,
          AppLocalizations.tutorialSchemeCardTitle,
          AppLocalizations.tutorialSchemeCardDescription),
    );

    _idleTargets.add(
      _targetFocusBuilder(_startKey, ContentAlign.top, ShapeLightFocus.RRect,
          '', AppLocalizations.tutorialStartButtonDescription,
          identity: 'startButton', textAlign: TextAlign.center),
    );

    _idleTargets.add(
      _targetFocusBuilder(
          _startCountDownKey,
          ContentAlign.bottom,
          ShapeLightFocus.Circle,
          '',
          AppLocalizations.tutorialStartTimerDescription,
          textAlign: TextAlign.center),
    );

    _idleTargets.add(
      _targetFocusBuilder(_startCountDownKey, ContentAlign.bottom,
          ShapeLightFocus.RRect, '', AppLocalizations.tutorialTimerDescription,
          textAlign: TextAlign.center),
    );
  }

  TargetFocus _targetFocusBuilder(GlobalKey key, ContentAlign align,
      ShapeLightFocus shape, String title, String description,
      {String identity = '', TextAlign textAlign = TextAlign.left}) {
    return TargetFocus(
      identify: identity.isNotEmpty ? identity : key.toString(),
      keyTarget: key,
      color: AppColors.accentColor,
      contents: [
        TargetContent(
          align: align,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title.isNotEmpty
                    ? Text(
                        title,
                        textAlign: textAlign,
                        style: AppTheme.customText(FontWeight.bold, 26),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                description.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          description,
                          textAlign: textAlign,
                          style:
                              AppTheme.customText(FontWeight.normal, 20),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      )
              ],
            ),
          ),
        )
      ],
      shape: shape,
      radius: 5,
    );
  }
}
