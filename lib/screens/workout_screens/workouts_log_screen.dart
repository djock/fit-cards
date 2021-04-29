import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/screens/workout_screens/workout_log_details_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/slidable_list_item.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutsLogScreen extends StatefulWidget {
  @override
  _WorkoutsLogScreenState createState() => _WorkoutsLogScreenState();
}

class _WorkoutsLogScreenState extends State<WorkoutsLogScreen> {
  List<Widget> _buildWorkoutsLog(BuildContext context) {
    List<Widget> _tempList = <Widget>[];

    if (AppState.loggedWorkouts.length > 0) {
      for (var workout in AppState.loggedWorkouts) {
        _tempList.add(SlidableListItem(
          leftValue: '',
          centerValue: workout.name,
          // Utils.formatDate(workout.date),
          rightValue: Utils.formatDateShort(workout.date),
          // Utils.formatTimeShort(workout.duration),
          deleteAction: () {
            AppState.loggedWorkouts.remove(workout);
            HiveHandler.saveWorkoutToBox();
            setState(() {});
          },
          onTap: () {
            Get.to(() => WorkoutLogDetailsScreen(
                  workoutLogModel: workout,
                ));
          },
        ));
      }
    } else {
      _tempList.add(Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: Text(
          AppLocalizations.noWorkoutsText,
          style: AppTheme.customAccentText(FontWeight.normal, 16),
          textAlign: TextAlign.center,
        ),
      )));
    }

    return _tempList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildNormal(AppLocalizations.workoutsLog),
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
