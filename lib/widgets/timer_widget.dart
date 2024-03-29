import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

enum timerType { timer, countdown }

class TimerWidgetController {
  late int duration;
}

class TimerWidget extends StatefulWidget {
  final int duration;
  final Function callback;
  final timerType type;
  final WorkoutController? workoutController;

  const TimerWidget(
      {Key? key,
      required this.callback,
      required this.duration,
      required this.type,
      required this.workoutController})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
  bool _disposed = false;

  @override
  void initState() {
    _timeInSec.value = widget.duration;

    if (widget.type == timerType.timer)
      startTimer();
    else
      startCountDown(widget.duration);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timeInSec.dispose();
    _disposed = true;
  }

  void startCountDown(int time) async {
    _timeInSec.value = time;
    while (_timeInSec.value >= 0) {
      if (_timeInSec.value == 0) {
        widget.callback();
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      if (!_disposed) _timeInSec.value--;
    }
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    if (oldWidget != widget) {
      if (oldWidget.duration != widget.duration) {
        if (widget.type == timerType.countdown) {
          startCountDown(widget.duration);
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void startTimer() async {
    _timeInSec.value = widget.duration;

    while (this.mounted) {
      await Future.delayed(Duration(seconds: 1));
      if (!_disposed) {
        _timeInSec.value++;
        if (widget.workoutController != null)
          widget.workoutController!.setDuration(_timeInSec.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _timeInSec,
        builder: (context, value, child) {
          return Text(Utils.formatTimeSeconds(int.parse(value!.toString())),
              style: TextStyle(
                color: Colors.red,
                fontSize: 60,
                fontFamily: 'digital',
              ),
              textAlign: TextAlign.center);
        });
  }
}
