import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
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
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'cards_screen.dart';

class TutorialCardsScreen extends StatefulWidget {
  @override
  _TutorialCardsScreenState createState() => _TutorialCardsScreenState();
}

class _TutorialCardsScreenState extends State<TutorialCardsScreen>
    with TickerProviderStateMixin {
  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  CountDownController _countDownController = new CountDownController();

  workoutState _state = workoutState.idle;

  TutorialCoachMark _tutorialCoachMark;
  List<TargetFocus> _idleTargets = List();
  List<TargetFocus> _activeTargets = List();

  GlobalKey _exerciseKey = GlobalKey();
  GlobalKey _schemeKey = GlobalKey();
  GlobalKey _startKey = GlobalKey();
  GlobalKey _startCountDownKey = GlobalKey();
  GlobalKey _timerKey = GlobalKey();
  GlobalKey _nextKey = GlobalKey();
  GlobalKey _stopKey = GlobalKey();

  @override
  void initState() {
    _initializeIdleTargets();
    _initializeActiveTargets();
    _startCountdown();
    super.initState();
  }

  Future<Null> _startCountdown() async {
    const timeOut = const Duration(milliseconds: 500);
    new Timer(timeOut, () {
      setState(() {
        _showIdleTutorial();
      });
    });
  }

  Future<Null> _delayTutorialNext() async {
    const timeOut = const Duration(seconds: 4);
    new Timer(timeOut, () {
      _tutorialCoachMark.finish();
    });
  }

  @override
  Widget build(BuildContext context) {

      return _state == workoutState.finish ?
      SafeScreen(
        appBar: null,
        body: Container(
          child: InkWell(
            onTap: () => {
              Navigator.pop(context)
            },
            child: Container(
              color: AppColors.mandarin,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.tutorialFinishDescription,
                      textAlign: TextAlign.center,
                      style:
                      AppTheme.customLightStyle(FontWeight.normal, 24),
                    ),
                    SizedBox(height: 30,),
                    Text(
                      AppLocalizations.tapToClose,
                      textAlign: TextAlign.center,
                      style:
                      AppTheme.customLightStyle(FontWeight.normal, 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ) :
        SafeScreen(
      appBar: _state == workoutState.active
          ? TimerAppBar(
              key: _timerKey,
            )
          : CustomAppBar.buildWithActions(context,
              [IconButton(icon: Icon(Icons.graphic_eq), onPressed: null)]),
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
                    isBlocked: false,
                    type: cardType.exercise,
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
                    isBlocked: false,
                    type: cardType.scheme,
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
                      _state == workoutState.active
                          ? _buildNextButton()
                          : SizedBox(
                              width: 0,
                            )
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
                      duration: 7,
                      initialDuration: 0,
                      controller: _countDownController,
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      ringColor: AppColors.mandarin.withOpacity(0.5),
                      ringGradient: null,
                      fillColor: AppColors.mandarin,
                      fillGradient: null,
                      backgroundColor: Colors.purple[500].withOpacity(0),
                      backgroundGradient: null,
                      strokeWidth: 12.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 50.0,
                          color: AppColors.mandarin,
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

  Widget _buildNextButton() {
    return CustomButton(
      key: _nextKey,
      buttonColor: AppColors.mandarin,
      onPressed: () {
        var currentExercise = new KeyValuePair(
            AppState.exercises[_exerciseController.index].name,
            AppState.schemes[_schemeController.index].name);
        AppState.activeExercisesList.add(new WorkoutExerciseModel(
            AppState.loggedWorkouts.length,
            currentExercise.key,
            currentExercise.value));

        _onSwipeCards();
      },
      textColor: AppColors.mainGrey,
      isOutline: false,
      isRequest: false,
      buttonText: AppLocalizations.next,
    );
  }

  Widget _buildStartButton() {
    return CustomButton(
      key: _state == workoutState.active ? _stopKey : _startKey,
      buttonColor: AppColors.mandarin,
      onPressed: () {
        if (_state == workoutState.active || _state == workoutState.countdown) {
          _onStopWorkout();
        } else {
          _onStartWorkout();
        }
      },
      textColor: AppColors.mainGrey,
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
    _tutorialCoachMark.finish();
    changeState(workoutState.finish);
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
    if (state == workoutState.active) {
      _showActiveTutorial();
    }
    setState(() {
      _state = state;
    });
  }

  void _initializeIdleTargets() {
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
        AppLocalizations.tutorialStartTimerDescription, textAlign: TextAlign.center
      ),
    );

    _idleTargets.add(
      _targetFocusBuilder(
        _startCountDownKey,
        ContentAlign.bottom,
        ShapeLightFocus.RRect,
        '',
        AppLocalizations.tutorialTimerDescription, textAlign: TextAlign.center
      ),
    );
  }

  void _initializeActiveTargets() {
    _activeTargets.add(
      _targetFocusBuilder(
        _timerKey,
        ContentAlign.bottom,
        ShapeLightFocus.RRect,
        '',
        AppLocalizations.tutorialTimerDescription, textAlign: TextAlign.center
      ),
    );

    _activeTargets.add(
      _targetFocusBuilder(
        _nextKey,
        ContentAlign.top,
        ShapeLightFocus.RRect,
        '',
        AppLocalizations.tutorialNextCardButtonDescription, textAlign: TextAlign.right
      ),
    );

    _activeTargets.add(
      _targetFocusBuilder(
        _stopKey,
        ContentAlign.top,
        ShapeLightFocus.RRect,
        '',
        AppLocalizations.tutorialStopButtonDescription,
        identity: 'stopButton'
      ),
    );
  }

  void _showIdleTutorial() {
    _tutorialCoachMark = TutorialCoachMark(
      context,
      targets: _idleTargets,
      colorShadow: Colors.red,
      textSkip: AppLocalizations.skip,
      paddingFocus: 10,
      opacityShadow: 0.9,
      onFinish: () {
      },
      onClickTarget: (target) {
        if (target.identify == 'startButton') {
          _onStartWorkout();
        }
      },
      onSkip: () {
      },
      onClickOverlay: (target) {
        _tutorialCoachMark.next();
      },
    )..show();
  }

  void _showActiveTutorial() {
    _tutorialCoachMark = TutorialCoachMark(
      context,
      targets: _activeTargets,
      colorShadow: Colors.red,
      textSkip: AppLocalizations.skip,
      paddingFocus: 10,
      opacityShadow: 0.9,
      onFinish: () {
      },
      onClickTarget: (target) {
        _tutorialCoachMark.next();
        if (target.identify == 'stopButton') {
          _onStopWorkout();
        }
      },
      onSkip: () {
      },
      onClickOverlay: (target) {
        _tutorialCoachMark.next();
      },
    )..show();
  }

  TargetFocus _targetFocusBuilder(GlobalKey key, ContentAlign align,
      ShapeLightFocus shape, String title, String description,
      {String identity = '', TextAlign  textAlign = TextAlign.left}) {
    return TargetFocus(
      identify: identity.isNotEmpty ? identity : key.toString(),
      keyTarget: key,
      color: AppColors.mandarin,
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
                        style: AppTheme.customLightStyle(FontWeight.bold, 26),
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
                              AppTheme.customLightStyle(FontWeight.normal, 20),
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
