import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/handlers/workout_state.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/screens/workout_end_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/customize_workout_modal.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum workoutState {
  countdown,
  active,
  idle,
  finish,
  rest,
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
        if (AppState.tutorialActive && _tutorialCoachMark != null)
          _tutorialCoachMark.finish();
      });
    }
  }

  PreferredSizeWidget _buildAppBar() {
    if (_state == workoutState.active ||
        _state == workoutState.rest ||
        _state == workoutState.rest && AppState.tutorialActive) {
      return TimerAppBar(
        key: _timerKey,
        callback: _onStopWorkout,
        buttonKey: _stopKey,
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
                        flex: 4,
                        child: FitCard(
                          key: _exerciseKey,
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
                          color: AppColors.schemeCardColor,
                          cardController: _schemeController,
                          isBlocked: _state == workoutState.rest ? true : false,
                          type: cardType.scheme,
                          onCallback: () {
                            _onSwipeSchemeCard();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
//                      Expanded(
//                        flex: 1,
//                        child: Row(
//                          mainAxisAlignment: _state == workoutState.active
//                              ? MainAxisAlignment.spaceEvenly
//                              : MainAxisAlignment.center,
//                          children: [
//                            _buildStartButton(),
////                            _state == workoutState.active
////                                ? _buildNextButton()
////                                : SizedBox(
////                                    width: 0,
////                                  )
//                          ],
//                        ),
//                      ),
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
            : WorkoutState.restTime
        : _state == workoutState.countdown
            ? 10
            : WorkoutState.restTime;

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
              key: _startCountDownKey,
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
                _delayTutorialNext();
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
    if (AppState.tutorialActive) _tutorialCoachMark.finish();

    if (_state == workoutState.countdown) {
      AppStateHandler.shuffleJson();
      changeState(workoutState.idle);
    } else {
      changeState(workoutState.finish);
    }

    if (_state == workoutState.countdown) return;

    var currentExercise = new KeyValuePair(
        AppState.exercises[_exerciseController.index].name,
        AppState.schemes[_schemeController.index].name);
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(AppState.loggedWorkouts.length,
        now, WorkoutState.trainingSessionMilliseconds);

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
  }

  void _onLogExercise() {
    var currentExercise = new KeyValuePair(
        AppState.exercises[_exerciseController.index].name,
        AppState.schemes[_schemeController.index].name);
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));
  }

  void _onSkipExercise() {
    _exerciseController.triggerLeft();
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
      textStyleSkip: AppTheme.customAccentText(FontWeight.bold, 18),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {},
      onClickTarget: (target) {
        if (target.identify == 'startButton') {
          _exerciseController.triggerLeft();
          _onStartWorkout();
        }
      },
      onSkip: () {
        UserPreferencesHandler.markTutorialAsFinished();
      },
      onClickOverlay: (target) {
        debugPrint('overlay');
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
      textStyleSkip: AppTheme.customAccentText(FontWeight.bold, 18),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {},
      onClickTarget: (target) {
        _tutorialCoachMark.next();
        if (target.identify == 'stopButton') {
          _onEndWorkout();
          _onStopWorkout();
        }

        if (target.identify == 'swipeCard') {
          _exerciseController.triggerLeft();
        }
      },
      onSkip: () {
        UserPreferencesHandler.markTutorialAsFinished();
        _onEndWorkout();
      },
      onClickOverlay: (target) {
        debugPrint('overlay');
        _tutorialCoachMark.next();
      },
    )..show();
  }

  void _onEndWorkout() {
    UserPreferencesHandler.markTutorialAsFinished();
  }

  void _onOpenFilters() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomizeWorkoutModal();
        });

//    showModalBottomSheet<void>(
//      context: context,
//      builder: (BuildContext context) {
//        return Container(
//          height: 200,
//          color: Colors.amber,
//          child: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                const Text('Modal BottomSheet'),
//                ElevatedButton(
//                  child: const Text('Close BottomSheet'),
//                  onPressed: () => Navigator.pop(context),
//                )
//              ],
//            ),
//          ),
//        );
//      },
//    );
  }

  ///::::::::::::::::::::::::::::::::::::::\\\
  ///:::::::::::::: TUTORIAL ::::::::::::::\\\
  ///::::::::::::::::::::::::::::::::::::::\\\

  GlobalKey _exerciseKey = GlobalKey();
  GlobalKey _schemeKey = GlobalKey();
  GlobalKey _startCountDownKey = GlobalKey();
  GlobalKey _timerKey = GlobalKey();
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
      _targetFocusBuilder(_exerciseKey, ContentAlign.bottom,
          ShapeLightFocus.RRect, '', AppLocalizations.tutorialSwipeExerciseCard,
          identity: 'swipeCard'),
    );

    _activeTargets.add(
      _targetFocusBuilder(_stopKey, ContentAlign.bottom, ShapeLightFocus.RRect,
          '', AppLocalizations.tutorialStopButtonDescription,
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
      _targetFocusBuilder(
          _exerciseKey,
          ContentAlign.bottom,
          ShapeLightFocus.RRect,
          '',
          AppLocalizations.tutorialStartButtonDescription,
          identity: 'startButton',
          textAlign: TextAlign.center),
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
      color: AppColors.canvasColorDark,
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
                        style: AppTheme.customAccentText(FontWeight.bold, 26),
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
                              AppTheme.customAccentText(FontWeight.normal, 20),
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
