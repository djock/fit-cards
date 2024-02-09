import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var work = 10;

  void _setState() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      debugPrint('_setState');
      work = 7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TimerWidget(
      duration: work,
      callback: () {
        _setState();
      },
      type: timerType.timer,
      workoutController: null,
    ));
  }
}
