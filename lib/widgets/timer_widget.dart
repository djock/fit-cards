import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

enum timerType { timer, countdown }

class TimerWidget extends StatefulWidget {
  final int duration;
  final Function callback;
  final timerType type;

  const TimerWidget({Key key, this.callback, this.duration, this.type})
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

  void startTimer() async {
    _timeInSec.value = 0;

    while (this.mounted) {
      await Future.delayed(Duration(seconds: 1));
      if (!_disposed) _timeInSec.value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == timerType.timer)
      startTimer();
    else
      startCountDown(widget.duration);

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
