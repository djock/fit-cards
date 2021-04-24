//import 'package:fitcards/handlers/app_state.dart';
//import 'package:fitcards/handlers/app_state_handler.dart';
//import 'package:fitcards/handlers/app_theme.dart';
//import 'package:fitcards/handlers/firebase_database_handler.dart';
//import 'package:fitcards/handlers/workout_controller.dart';
//import 'package:fitcards/models/workout_exercise_model.dart';
//import 'package:fitcards/models/workout_log_model.dart';
//import 'package:fitcards/screens/workout_screens/workout_end_screen.dart';
//import 'package:fitcards/utilities/app_colors.dart';
//import 'package:fitcards/utilities/app_localizations.dart';
//import 'package:fitcards/utilities/key_value_pair_model.dart';
//import 'package:fitcards/widgets/circular_countdown_timer/circular_countdown_timer.dart';
//import 'package:fitcards/widgets/custom_app_bar.dart';
//import 'package:fitcards/widgets/customize_workout_modal.dart';
//import 'package:fitcards/widgets/fit_card.dart';
//import 'package:fitcards/widgets/flutter_tindercard.dart';
//import 'package:fitcards/widgets/safe_screen.dart';
//import 'package:fitcards/widgets/timer_app_bar.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:get/get.dart';
//
//class WorkoutScreen extends StatefulWidget {
//  @override
//  _WorkoutScreenState createState() => _WorkoutScreenState();
//}
//
//class _WorkoutScreenState extends State<WorkoutScreen>
//    with TickerProviderStateMixin {
//  CardController _exerciseController = new CardController();
//  CardController _schemeController = new CardController();
//
//  WorkoutController _workoutController = new WorkoutController(workoutType.hiit, AppState.hiitSettings);
//
//  CountDownController _countDownController = new CountDownController();
//
//  workoutState _state = workoutState.idle;
//
//
//  PreferredSizeWidget _buildAppBar() {
//    if (_state == workoutState.active ||
//        _state == workoutState.rest ||
//        _state == workoutState.rest && AppState.tutorialActive) {
//      return TimerAppBar(
//        callback: _onStopWorkout,
//        isInRest: _state == workoutState.rest,
//      );
//    }
//
//    if (_state == workoutState.rest) {
//      return CustomAppBar.buildRest([
//        IconButton(
//            icon: FaIcon(
//              FontAwesomeIcons.times,
//              size: 35,
//              color: Colors.red,
//            ),
//            onPressed: () {
//              _onStopWorkout();
//            })
//      ], text: AppLocalizations.rest, iconSize: 40);
//    }
//
//    if (_state == workoutState.countdown) {
//      return CustomAppBar.buildWorkout(AppLocalizations.getReady);
//    }
//
//    return CustomAppBar.buildWithActions([
//      IconButton(
//          icon: FaIcon(
//            FontAwesomeIcons.slidersH,
//            color: Get.isDarkMode
//                ? Theme.of(Get.context).accentColor
//                : Theme.of(Get.context).primaryColorDark,
//            size: 18,
//          ),
//          onPressed: () {
//            _onOpenFilters();
//          })
//    ], iconSize: 20.0);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _state == workoutState.finish
//        ? WorkoutEndScreen()
//        : SafeScreen(
//      appBar: _buildAppBar(),
//      body: Stack(
//        children: [
//          Container(
//            padding: EdgeInsets.only(top: 10, bottom: 10),
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height * 0.91,
//            child: Column(
//              children: [
//                Expanded(
//                  flex: 4,
//                  child: FitCard(
//                    list: AppState.exercises,
//                    color: AppColors.exerciseCardColor,
//                    cardController: _exerciseController,
//                    isBlocked:
//                    _state == workoutState.countdown ? true : false,
//                    type: cardType.exercise,
//                    onCallback: () {
//                      _onSwipeExerciseCard();
//                    },
//                    onSkip: () {
//                      _onSkipExercise();
//                    },
//                    isFake: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Expanded(
//                  flex: 4,
//                  child: FitCard(
//                    list: AppState.schemes,
//                    color: AppColors.schemeCardColor,
//                    cardController: _schemeController,
//                    isBlocked: _state == workoutState.rest || _state == workoutState.idle ? true : false,
//                    type: cardType.scheme,
//                    onCallback: () {
//                      _onSwipeSchemeCard();
//                    },
//                    isFake: false,
//                  ),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//              ],
//            ),
//          ),
//          _state == workoutState.countdown ||
//              _state == workoutState.rest && !AppState.tutorialActive
//              ? Align(
//            alignment: Alignment.center,
//            child: Container(
//              color: AppTheme.countDownTimerColor(),
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              child: Center(
//                child: _buildCountDownTimer(),
//              ),
//            ),
//          )
//              : SizedBox(
//            height: 0,
//          )
//        ],
//      ),
//    );
//  }
//
//  bool _countDownPaused = false;
//
//  Widget _buildCountDownTimer() {
//    var timerDuration = AppState.tutorialActive
//        ? _state == workoutState.rest
//        ? 0
//        : _workoutController.settings.restTime
//        : _state == workoutState.countdown
//        ? 10
//        : _workoutController.settings.restTime;
//
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        Padding(
//          padding: const EdgeInsets.only(bottom: 18.0),
//          child: InkWell(
//            onTap: () {
//              if (_state == workoutState.countdown) {
//                if (_countDownPaused) {
//                  _countDownController.resume();
//                  setState(() {
//                    _countDownPaused = false;
//                  });
//                } else {
//                  _countDownController.pause();
//                  setState(() {
//                    _countDownPaused = true;
//                  });
//                }
//              }
//            },
//            child: CircularCountDownTimer(
//              duration: timerDuration,
//              initialDuration: 0,
//              controller: _countDownController,
//              width: MediaQuery.of(context).size.width / 3,
//              height: MediaQuery.of(context).size.height / 3,
//              ringColor: Colors.red.withOpacity(0.65),
//              ringGradient: null,
//              fillColor: Colors.red,
//              fillGradient: null,
//              backgroundColor: Colors.purple[500].withOpacity(0),
//              backgroundGradient: null,
//              strokeWidth: 12.0,
//              strokeCap: StrokeCap.round,
//              textStyle: TextStyle(
//                  fontSize: 50.0,
//                  color: Colors.red,
//                  fontWeight: FontWeight.bold),
//              textFormat: CountdownTextFormat.S,
//              isReverse: true,
//              isReverseAnimation: false,
//              isTimerTextShown: true,
//              autoStart: true,
//              onStart: () {
//              },
//              onComplete: () {
//                if (_state == workoutState.countdown)
//                  changeState(workoutState.active);
//
//                if (_state == workoutState.rest)
//                  changeState(workoutState.active);
//              },
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//
//  void _onStartWorkout() {
//    changeState(workoutState.countdown);
//  }
//
//  void _onStopWorkout() {
//    if (AppState.tutorialActive) {
//      changeState(workoutState.finish);
//      return;
//    }
//
//    if (_state == workoutState.countdown) {
//      AppStateHandler.shuffleJson();
//      changeState(workoutState.idle);
//    } else {
//      changeState(workoutState.finish);
//    }
//
//    if (_state == workoutState.countdown) return;
//
//    var now = DateTime.now();
//    var currentWorkout = new WorkoutLogModel(AppState.loggedWorkouts.length,
//        now, WorkoutState.trainingSessionMilliseconds, _workoutController.exercisesCount, _workoutController.points);
//
//    AppStateHandler.logExercise();
//    AppStateHandler.logWorkout(currentWorkout);
//  }
//
//  void _onSwipeExerciseCard() {
//    if (_state == workoutState.active) {
//      if (_exerciseController.hasSkipped) {
//        _schemeController.cancelCallback = true;
//        _schemeController.triggerLeft();
//        _exerciseController.hasSkipped = false;
//      } else {
//        _onSwipeSuccess(_schemeController);
//      }
//    }
//
//    if (_state == workoutState.active ||
//        _state == workoutState.countdown ||
//        _state == workoutState.rest) return;
//
//    _onStartWorkout();
//    _schemeController.triggerLeft();
//  }
//
//  void _onSwipeSchemeCard() {
//    if (_state == workoutState.active) {
//      _onSwipeSuccess(_exerciseController);
//    }
//  }
//
//  void _onSwipeSuccess(CardController otherController) {
//    _onLogExercise();
//    otherController.cancelCallback = true;
//    otherController.triggerLeft();
//    changeState(workoutState.rest);
//  }
//
//  void _onLogExercise() {
//    if(!AppState.tutorialActive) {
//      var currentExercise = new KeyValuePair(
//          AppState.exercises[_exerciseController.index].name,
//          AppState.schemes[_schemeController.index].name);
//      AppState.activeExercisesList.add(new WorkoutExerciseModel(
//          AppState.loggedWorkouts.length,
//          currentExercise.key,
//          currentExercise.value));
//
//
//      _workoutController.countExercise();
//      _workoutController.addPoints(_exerciseController.points);
//    }
//  }
//
//  void _onSkipExercise() {
//    _exerciseController.triggerLeft();
//  }
//
//  void changeState(workoutState state) {
//    setState(() {
//      _state = state;
//    });
//  }
//
//  void _onOpenFilters() {
//    FirebaseDatabaseHandler.updateLeaderBoard();
//
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return CustomizeWorkoutModal(workoutController: _workoutController,);
//        });
//  }
//}