import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class StatsScreen extends StatelessWidget {
  int _sessionsDone = 0;
  int _uniqueExercises = 0;
  int _averageDuration = 0;
  int _averagePoints = 0;

  void _getStats() {
    if (AppState.loggedWorkouts.length > 0) {
      var index = 0;
      var totalDuration = 0;
      var totalPoints = 0;
      List<String> exercises = [];

      for (var workout in AppState.loggedWorkouts) {
        index++;
        totalDuration += workout.duration;
        totalPoints += workout.points;

        var exercisesList = AppState.loggedExercisesList.where((element) => element.index == workout.index).toList();

        for (var exercise in exercisesList) {
          if(!exercises.contains(exercise)) {
            exercises.add(exercise.exercise);
          }
        }
      }


      _averageDuration = totalDuration ~/ index;
      _averagePoints = totalPoints ~/ index;
      _sessionsDone = index;
      _uniqueExercises = exercises.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    _getStats();

    return SafeScreen(
      appBar: CustomAppBar.buildNormal(AppLocalizations.statistics),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Table(
              border: TableBorder.symmetric(
                  inside: BorderSide(color: Theme.of(Get.context).accentColor)),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                _buildHeaderRow(
                    _buildHeaderTile(
                        AppLocalizations.sessionsDone, _sessionsDone.toString()),
                    _buildHeaderTile(AppLocalizations.exercisesDone, _uniqueExercises.toString())),
                _buildHeaderRow(
                    _buildHeaderTile(AppLocalizations.averagePoints, _averagePoints.toString()),
                    _buildHeaderTile(AppLocalizations.averageDuration,
                        Utils.formatTimeShort(_averageDuration ~/ 1000))),
              ],
            ),
          ),
          SizedBox(height: 20,),
          _buildButtons()
        ],
      ),
    );
  }

  TableRow _buildHeaderRow(Widget firstTile, Widget secondTile) {
    return TableRow(
      children: <Widget>[
        Center(
          child: firstTile,
        ),
        Center(child: secondTile),
      ],
    );
  }

  Widget _buildHeaderTile(String title, String value) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(title,
                style: AppTheme.customAccentText(FontWeight.normal, 14),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              value,
              style: AppTheme.textAccentBold30(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          _buildSectionListItem(AppLocalizations.workoutsLog, FontAwesomeIcons.calendarAlt, FontAwesomeIcons.chevronRight, () {Get.to(() => WorkoutsLogScreen());}),
          SizedBox(
            height: 20,
          ),
          _buildSectionListItem(AppLocalizations.leaderBoard, FontAwesomeIcons.trophy, FontAwesomeIcons.chevronRight, () {Get.to(() => LeaderBoardScreen());}),
        ],
      ),
    );
  }

  Widget _buildSectionListItem(
      String text, IconData leftIcon, IconData rightIcon, Function function) {
    return Container(
      color: Theme.of(Get.context).canvasColor,
      child: ListTile(
        onTap: () {
          if (function != null) {
            function();
          }
        },
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        title: Text(
          text,
          style: AppTheme.customAccentText(FontWeight.bold, 16),
        ),
        leading: _buildIcon(leftIcon, AppTheme.dynamicColor()),
        trailing: rightIcon != null
            ? _buildIcon(rightIcon, AppTheme.dynamicColor())
            : SizedBox(),
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: FaIcon(
        icon,
        color: color,
      ),
    );
  }
}
