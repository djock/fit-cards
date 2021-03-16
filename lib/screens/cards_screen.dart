import 'dart:math';

import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/json_data_handler.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen>
    with TickerProviderStateMixin {
  ExerciseModel _exercise =
      JsonDataHandler.exercises[0]; // ignore: unused_field
  SchemeModel _scheme = JsonDataHandler.schemes[0]; // ignore: unused_field

  CardController _exerciseController = new CardController();
  CardController _schemeController = new CardController();

  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: _isActive
          ? CustomAppBar.buildEmptyNoBack(context)
          : CustomAppBar.buildEmpty(context),
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
                    list: JsonDataHandler.exercises,
                    color: Colors.white,
                    cardController: _exerciseController,
                    isInteractive: _isActive,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 4,
                  child: FitCard(
                    list: JsonDataHandler.schemes,
                    color: Colors.white,
                    cardController: _schemeController,
                    isInteractive: _isActive,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: _isActive
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      _buildStartButton(),
                      _isActive
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
          _isActive
              ? Align(alignment: Alignment.topCenter, child: CardsTimer())
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return CustomButton(
      buttonColor: AppColors.mandarin,
      onPressed: () {
        var currentExercise = new KeyValuePair(
            JsonDataHandler.exercises[_exerciseController.index].name,
            JsonDataHandler.schemes[_schemeController.index].name);
        AppState.activeExercisesList.add(new WorkoutExerciseModel(
            AppState.loggedWorkouts.length,
            currentExercise.key,
            currentExercise.value));

        var exerciseRandom = new Random();
        if (exerciseRandom.nextBool()) {
          _exerciseController.triggerLeft();
          _schemeController.triggerLeft();
        } else {
          _exerciseController.triggerRight();
          _schemeController.triggerRight();
        }
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
        if (_isActive) {
          var currentExercise = new KeyValuePair(
              JsonDataHandler.exercises[_exerciseController.index].name,
              JsonDataHandler.schemes[_schemeController.index].name);
          AppState.activeExercisesList.add(new WorkoutExerciseModel(
              AppState.loggedWorkouts.length,
              currentExercise.key,
              currentExercise.value));

          var now = DateTime.now();
          var currentWorkout = new WorkoutLogModel(
              AppState.loggedWorkouts.length,
              now,
              AppState.trainingSessionMilliseconds);

          AppState.logExercise();
          AppState.logWorkout(currentWorkout);
        }

        setState(() {
          _isActive = !_isActive;
        });
      },
      textColor: AppColors.mainGrey,
      isOutline: false,
      isRequest: false,
      buttonText: _isActive ? AppLocalizations.stop : AppLocalizations.start,
    );
  }
}
