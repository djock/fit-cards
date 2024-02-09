import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsTable extends StatelessWidget {
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

        var exercisesList = AppState.loggedExercisesList
            .where((element) => element.index == workout.index)
            .toList();

        for (var exercise in exercisesList) {
          if (!exercises.contains(exercise)) {
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

    return Table(
      border: TableBorder.symmetric(
          inside: BorderSide(color: Theme.of(Get.context!).primaryColor)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        _buildHeaderRow(
            _buildHeaderTile(
                AppLocalizations.sessionsDone, _sessionsDone.toString()),
            _buildHeaderTile(
                AppLocalizations.exercisesDone, _uniqueExercises.toString())),
        _buildHeaderRow(
            _buildHeaderTile(
                AppLocalizations.averagePoints, _averagePoints.toString()),
            _buildHeaderTile(AppLocalizations.averageDuration,
                Utils.formatTimeShort(_averageDuration ~/ 1000))),
      ],
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
}
