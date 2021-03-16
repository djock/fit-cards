import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/exercise_widget.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class WorkoutLogDetailsScreen extends StatelessWidget {
  final int workoutIndex;

  const WorkoutLogDetailsScreen({Key key, this.workoutIndex}) : super(key: key);

  List<Widget> _buildExercisesList() {
    var exercisesList = AppState.loggedExercisesList.where((element) => element.index == workoutIndex).toList();
    
    List<Widget> _tempList = <Widget>[];

    var index = 1;

    for (var exercise in exercisesList) {
      _tempList.add(ListItem(
        leftValue: index.toString(),
        centerValue: exercise.exercise + ' ' + exercise.scheme,
        rightValue: '',
        onTap: null
      ));
      index++;
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
              children: _buildExercisesList(),
            ),
          )),
    );
  }
}