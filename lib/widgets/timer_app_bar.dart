import 'dart:async';

import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TimerAppBar extends StatefulWidget with PreferredSizeWidget{
  final Function callback;
  final GlobalKey buttonKey;

  const TimerAppBar({Key key, this.callback, this.buttonKey,}) : super(key: key);

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
    return CustomAppBar.buildTimer(_stopwatch.elapsedMilliseconds, widget.callback, widget.buttonKey);
  }
}
