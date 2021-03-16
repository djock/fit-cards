import 'dart:async';

import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/utilities/json_data_handler.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotUsedTrainScreen extends StatefulWidget {
  final int exerciseIndex;
  final int schemeIndex;

  const NotUsedTrainScreen({Key key, this.exerciseIndex, this.schemeIndex})




      : super(key: key);

  @override
  _NotUsedTrainScreenState createState() => _NotUsedTrainScreenState();
}

class _NotUsedTrainScreenState extends State<NotUsedTrainScreen> {
  Stopwatch _stopwatch;
  Timer _timer;

  int _exerciseIndex = 0;
  int _schemeIndex = 0;

  @override
  void initState() {
    super.initState();

    _schemeIndex = widget.schemeIndex;
    _exerciseIndex = widget.exerciseIndex;

    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: CustomAppBar.buildEmpty(context),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTotalTimer(),
                            _buildTimer(),
                            SizedBox(
                              height: 50,
                            ),
                            _buildCurrentExercise(),
                            _buildCurrentScheme(),
                            SizedBox(
                              height: 50,
                            ),
                            _buildNextRound(),
                          ],
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          buttonColor: AppColors.mandarin,
                          onPressed: () {
                            handleStartStop();
                          },
                          textColor: AppColors.mainGrey,
                          isOutline: false,
                          isRequest: false,
                          buttonText: _stopwatch.isRunning ? 'Stop' : 'Start',
                        ),
                        _stopwatch.isRunning
                            ? SizedBox(
                                width: 30,
                              )
                            : SizedBox(
                                width: 0,
                              ),
                        _stopwatch.isRunning
                            ? CustomButton(
                                buttonColor: AppColors.mandarin,
                                onPressed: () {
                                  setState(() {
                                    AppState.trainingSessionMilliseconds +=
                                        _stopwatch.elapsedMilliseconds;

                                    _stopwatch.reset();
                                    _exerciseIndex += 1;
                                    _schemeIndex += 1;
                                  });
                                },
                                textColor: AppColors.mainGrey,
                                isOutline: false,
                                isRequest: false,
                                buttonText: 'Next',
                              )
                            : SizedBox(
                                width: 0,
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentExercise() {
    var currentExercise = JsonDataHandler.exercises[_exerciseIndex];
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
        child: Text('${currentExercise.name}', style: _currentLabelStyle(),  textAlign: TextAlign.center,),);
  }

  Text _buildCurrentScheme() {
    var currentScheme = JsonDataHandler.schemes[_schemeIndex];
    return Text(
      '${currentScheme.name}',
      style: _currentLabelStyle(),
      textAlign: TextAlign.center,
    );
  }

  Text _buildNextRound() {
    var nextExercise = JsonDataHandler.exercises[_exerciseIndex + 1];
    var nextScheme = JsonDataHandler.schemes[_schemeIndex + 1];
    var suffix = nextScheme.type == schemeType.reps ? ' for reps' : ' for time';

    return Text('Next: ${nextExercise.name} $suffix', style: _nextLabelStyle(), textAlign: TextAlign.center,);
  }

  Widget _buildTimer() {
    return Container(
      color: AppColors.mainColor,
      padding: EdgeInsets.all(10),
      child: Text(
        Utils.formatTime(_stopwatch.elapsedMilliseconds),
        style: TextStyle(color: AppColors.textColor, fontSize: 50),
      ),
    );
  }

  Widget _buildTotalTimer() {
    return Container(
      color: AppColors.mainColor,
      padding: EdgeInsets.all(10),
      child: Text(
        Utils.formatTime(AppState.trainingSessionMilliseconds),
        style: TextStyle(color: AppColors.textColor, fontSize: 50),
      ),
    );
  }

  TextStyle _currentLabelStyle() {
    return TextStyle(color: AppColors.mainColor, fontSize: 40,);
  }

  TextStyle _nextLabelStyle() {
    return TextStyle(
        color: AppColors.mainColor, fontSize: 14, fontStyle: FontStyle.italic);
  }
}
