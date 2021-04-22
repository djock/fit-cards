import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int timer;
  final Function callback;

  const TimerWidget({Key key, this.callback, this.timer})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
  bool _disposed = false;

  @override
  void initState() {
    _timeInSec.value = widget.timer;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timeInSec.dispose();
    _disposed = true;
  }

  void startTimer(int time) async {
    _timeInSec.value = time;

    while (_timeInSec.value >= 0) {

      if(_timeInSec.value == 0) {
        widget.callback();
        return;
      }

      await Future.delayed(Duration(seconds: 1));
      if(!_disposed)
        _timeInSec.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimer(widget.timer);

    return ValueListenableBuilder(
        valueListenable: _timeInSec,
        builder: (context, value, child) {
          return Text(Utils.formatTimeSeconds(value),
              style: TextStyle(
                color: Colors.red,
                fontSize: 60,
                fontFamily: 'digital',
              ),
              textAlign: TextAlign.center);
        });
  }
}
