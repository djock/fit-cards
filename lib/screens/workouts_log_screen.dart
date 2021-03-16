import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class WorkoutsLogScreen extends StatelessWidget {
  List<Widget> _buildWorkoutsLog() {
    List<Widget> _tempList = <Widget>[];

    for (var log in AppState.loggedExercisesList) {
      _tempList.add(Text('[${log.index}] ${log.exercise} | ${log.scheme}'));
    }

    return _tempList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: CustomAppBar.buildNormal(context, 'Workouts Log'),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildWorkoutsLog(),
        ),
      )),
    );
  }
}
