import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

enum timerType { timer, countdown }

class TimerWidgetController {
  int duration;
}

class TimerWidget extends StatefulWidget {
  final int duration;
  final Function callback;
  final timerType type;
  final WorkoutController workoutController;

  const TimerWidget(
      {Key key,
      this.callback,
      this.duration,
      this.type,
      this.workoutController})
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
    if(oldWidget != widget) {
      debugPrint('update widget');
      if(oldWidget.duration != widget.duration) {
        if(widget.type == timerType.countdown) {
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
          widget.workoutController.setDuration(_timeInSec.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _timeInSec,
        builder: (context, value, child) {
          _playAudio();
          return Text(Utils.formatTimeSeconds(value),
              style: TextStyle(
                color: Colors.red,
                fontSize: 60,
                fontFamily: 'digital',
              ),
              textAlign: TextAlign.center);
        });
  }

  void _playAudio() {
    if (AppState.audioEnabled && widget.type == timerType.countdown) {
      if (_timeInSec.value == 3) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/tick.flac"),
          autoStart: true,
          showNotification: true,
        );
      }

      if (_timeInSec.value == 2) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/tick.flac"),
          autoStart: true,
          showNotification: true,
        );
      }

      if (_timeInSec.value == 1) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/tick.flac"),
          autoStart: true,
          showNotification: true,
        );
      }

      if (_timeInSec.value == 0) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/start.flac"),
          autoStart: true,
          showNotification: true,
        );
      }
    }
  }
}
