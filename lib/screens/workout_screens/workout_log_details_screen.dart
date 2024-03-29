import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/list_item.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/slidable_list_item.dart';
import 'package:flutter/material.dart';

class WorkoutLogDetailsScreen extends StatelessWidget {
  final WorkoutLogModel? workoutLogModel;

  const WorkoutLogDetailsScreen({Key? key, this.workoutLogModel})
      : super(key: key);

  List<Widget> _buildExercisesList() {
    var exercisesList = AppState.loggedExercisesList
        .where((element) => element.index == workoutLogModel!.index)
        .toList();

    List<Widget> _tempList = <Widget>[];

    var index = 1;

    _tempList.add(_buildHeader());

    _tempList.add(Divider(
      thickness: 2,
    ));

    for (var exercise in exercisesList) {
      _tempList.add(SlidableListItem(
        leftValue: index.toString(),
        centerValue: exercise.exercise,
        rightValue: exercise.scheme,
        onTap: () {},
        deleteAction: () {},
        shareAction: () {},
        backgroundColor: Colors.black,
      ));
      index++;
    }

    return _tempList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildNormal(workoutLogModel!.name),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildExercisesList(),
        ),
      )),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.widgetBackground(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListItem(
            leftValue: '',
            centerValue: AppLocalizations.date,
            rightValue: Utils.formatDate(workoutLogModel!.date),
            backgroundColor: Colors.red,
          ),
          ListItem(
              leftValue: '',
              centerValue: AppLocalizations.duration,
              rightValue: Utils.formatTimeShort(workoutLogModel!.duration),
              backgroundColor: Colors.red),
          ListItem(
              leftValue: '',
              centerValue: AppLocalizations.points,
              rightValue: workoutLogModel!.points.toString(),
              backgroundColor: Colors.red),
        ],
      ),
    );
  }
}
