import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/screens/workout_log_details_screen.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/exercise_widget.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutsLogScreen extends StatelessWidget {
  List<Widget> _buildWorkoutsLog(BuildContext context) {
    List<Widget> _tempList = <Widget>[];

    for (var workout in AppState.loggedWorkouts) {
      var formatter = DateFormat('dd MMM, yyyy').add_jm();
      var formattedDate = formatter.format(workout.date).toUpperCase();

      _tempList.add(ListItem(
        leftValue: workout.index.toString(),
        centerValue: formattedDate,
        rightValue: Utils.formatTimeShort(workout.duration ~/ 1000),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkoutLogDetailsScreen(workoutIndex: workout.index,)));
        },
      ));
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
          children: _buildWorkoutsLog(context),
        ),
      )),
    );
  }
}
