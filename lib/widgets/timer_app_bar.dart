import 'dart:async';

import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TimerAppBar extends StatefulWidget with PreferredSizeWidget{
  @override
  _TimerAppBarState createState() => _TimerAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TimerAppBarState extends State<TimerAppBar> {
  Stopwatch _stopwatch;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();
    handleStartStop();

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
    AppState.trainingSessionMilliseconds = _stopwatch.elapsedMilliseconds;
    return CustomAppBar.buildTimer(_stopwatch.elapsedMilliseconds);
  }

  Widget _buildTimer() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: 70,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: AppColors.mainColor,
        ),
        child: Text(Utils.formatTime(_stopwatch.elapsedMilliseconds),
            style: TextStyle(
              color: Colors.red,
              fontSize: 60,
              fontFamily: 'digital',
            ),
            textAlign: TextAlign.center),
      ),
    );
  }
}