import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: _state == workoutState.active
          ? TimerAppBar()
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
                    list: AppState.schemes,
                    color: Colors.white,
                    cardController: _schemeController,
                    isBlocked: true,
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
          _state == workoutState.countdown ? Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: CircularCountDownTimer(
                duration: 5,
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
                  print('Countdown Started');
                },
                onComplete: () {
                    changeState(workoutState.active);
                    _onSwipeCards();
                  print('Countdown Ended');
                },
              ),
            ),
          ) : SizedBox(height: 0,)
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return CustomButton(
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
      buttonText: _state == workoutState.active || _state == workoutState.countdown ? AppLocalizations.stop : AppLocalizations.start,
    );
  }

  void _onStartWorkout() {
    changeState(workoutState.countdown);
  }

  void _onStopWorkout(){
    var currentExercise = new KeyValuePair(
        AppState.exercises[_exerciseController.index].name,
        AppState.schemes[_schemeController.index].name);
    AppState.activeExercisesList.add(new WorkoutExerciseModel(
        AppState.loggedWorkouts.length,
        currentExercise.key,
        currentExercise.value));

    var now = DateTime.now();
    var currentWorkout = new WorkoutLogModel(
        AppState.loggedWorkouts.length,
        now,
        AppState.trainingSessionMilliseconds);

    AppStateHandler.logExercise();
    AppStateHandler.logWorkout(currentWorkout);

    changeState(workoutState.idle);
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
    setState(() {
      _state = state;
    });
  }
}
