import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/list_item.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class WorkoutLogDetailsScreen extends StatelessWidget {
  final WorkoutLogModel workoutLogModel;

  const WorkoutLogDetailsScreen({Key key, this.workoutLogModel}) : super(key: key);

  List<Widget> _buildExercisesList() {
    var exercisesList = AppState.loggedExercisesList.where((element) => element.index == workoutLogModel.index).toList();
    
    List<Widget> _tempList = <Widget>[];

    var index = 1;

    for (var exercise in exercisesList) {
      _tempList.add(ListItem(
        leftValue: index.toString(),
        centerValue: exercise.exercise,
        rightValue: exercise.scheme,
        onTap: null
      ));
      index++;
    }

    return _tempList;
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildNormal(Utils.formatDate(workoutLogModel.date)),
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