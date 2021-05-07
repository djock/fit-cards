import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/exercises_list_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomizeWorkoutModal extends StatefulWidget {
  final WorkoutController workoutController;

  const CustomizeWorkoutModal({Key key, this.workoutController})
      : super(key: key);

  @override
  _CustomizeWorkoutModal createState() => _CustomizeWorkoutModal();
}

class _CustomizeWorkoutModal extends State<CustomizeWorkoutModal> {
  int _restTime = 10;
  int _workTime = 20;
  int _rounds = 8;
  int _maxDuration = 0;

  bool _canSkip = false;
  bool _changeOccurred = false;

  @override
  void initState() {
    _restTime = widget.workoutController.settings.restTime;
    _canSkip = widget.workoutController.settings.canSkipExercise;
    _rounds = widget.workoutController.settings.rounds;
    _maxDuration = widget.workoutController.settings.maxDuration;
    _workTime = widget.workoutController.settings.workTime;

    _changeOccurred = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
      color: AppTheme.widgetBackground(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: _changeOccurred ? Colors.green : AppTheme.widgetBackground(),
                ),
                height: 5,
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.customize,
                textAlign: TextAlign.center,
                style: AppTheme.customAccentText(FontWeight.bold, 20),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _buildSkipExerciseCheckbox(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoundsSelector(),
              _buildDynamicSpace(),
              _buildPunctuation('   X   '),
              _buildDynamicSpace(),
              _buildWorkSelector(),
              _buildDynamicSpace(),
              _buildPunctuation('   /   '),
              _buildDynamicRestSelector(),
            ],
          ),
          _buildDynamicSpace(),
          _buildTooltip(),
          _buildExercisesList(),
        ],
      ),
//      actions: <Widget>[
//        new FlatButton(
//          onPressed: () {
//            var settings = new WorkoutSettingsModel(
//                _rounds, _restTime, _workTime, _canSkip, _maxDuration);
//
//            if (widget.workoutController.type == workoutType.tabata) {
//              AppState.tabataSettings = settings;
//            } else {
//              AppState.hiitSettings = settings;
//            }
//
//            widget.workoutController.setSettings(settings);
//            if(widget.callback != null) widget.callback();
//
//            Navigator.of(context).pop();
//          },
//          child: Text(
//            _changeOccurred ? AppLocalizations.apply : AppLocalizations.close,
//            style: AppTheme.textAccentBold15(),
//          ),
//        ),
//      ],
    );
  }

  Widget _buildDynamicSpace() {
    return widget.workoutController.type == workoutType.tabata
        ? SizedBox(
            height: 20,
          )
        : SizedBox();
  }

  Widget _buildSkipExerciseCheckbox() {
    return widget.workoutController.type == workoutType.hiit
        ? Theme(
            data:
                ThemeData(unselectedWidgetColor: Theme.of(context).accentColor),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              activeColor: Theme.of(context).accentColor,
              checkColor: Theme.of(context).canvasColor,
              selectedTileColor: Theme.of(context).accentColor,
              title: Text(
                AppLocalizations.skipExercise,
                style: AppTheme.customAccentText(FontWeight.normal, 14),
              ),
              value: _canSkip,
              onChanged: (bool value) {
                setState(() {
                  _changeOccurred = true;
                  _canSkip = value;

                  _setState();
                });
              },
            ),
          )
        : SizedBox();
  }

  Widget _buildRoundsSelector() {
    return widget.workoutController.type == workoutType.tabata
        ? NumberPicker(
            value: _rounds,
            haptics: true,
            minValue: 5,
            maxValue: 30,
            itemCount: 3,
            step: 1,
            itemHeight: 30,
            itemWidth: 30,
            textStyle: AppTheme.customAccentText(FontWeight.normal, 13),
            selectedTextStyle: AppTheme.textAccentBold15(),
            axis: Axis.vertical,
            onChanged: (value) => setState(() {
              _changeOccurred = true;
              _rounds = value;

              _setState();
            }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).accentColor),
            ),
          )
        : SizedBox();
  }

  Widget _buildWorkSelector() {
    return widget.workoutController.type == workoutType.tabata
        ? NumberPicker(
            key: new GlobalKey(),
            value: _workTime,
            haptics: true,
            minValue: 5,
            maxValue: 90,
            itemCount: 3,
            step: 5,
            itemHeight: 30,
            itemWidth: 30,
            textStyle: AppTheme.customAccentText(FontWeight.normal, 13),
            selectedTextStyle: AppTheme.textAccentBold15(),
            axis: Axis.vertical,
            onChanged: (value) => setState(() {
              _changeOccurred = true;
              _workTime = value;

              _setState();
            }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).accentColor),
            ),
          )
        : SizedBox();
  }

  Widget _buildDynamicRestSelector() {
    if (widget.workoutController.type == workoutType.tabata) {
      return _buildRestSelector();
    } else {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.chooseRestTime,
              style: AppTheme.customAccentText(FontWeight.normal, 14),
              overflow: TextOverflow.clip,
            ),
            NumberPicker(
              key: new GlobalKey(),
              value: _restTime,
              haptics: true,
              minValue: 5,
              maxValue: 90,
              itemCount: 3,
              step: 5,
              itemHeight: 30,
              itemWidth: 30,
              textStyle: AppTheme.customAccentText(FontWeight.normal, 13),
              selectedTextStyle: AppTheme.textAccentBold15(),
              axis: Axis.horizontal,
              onChanged: (value) => setState(() {
                _changeOccurred = true;
                _restTime = value;

                _setState();
              }),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildRestSelector() {
    return NumberPicker(
      key: new GlobalKey(),
      value: _restTime,
      haptics: true,
      minValue: 5,
      maxValue: 90,
      itemCount: 3,
      step: 5,
      itemHeight: 30,
      itemWidth: 30,
      textStyle: AppTheme.customAccentText(FontWeight.normal, 13),
      selectedTextStyle: AppTheme.textAccentBold15(),
      axis: Axis.vertical,
      onChanged: (value) => setState(() {
        _changeOccurred = true;
        _restTime = value;

        _setState();
      }),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).accentColor),
      ),
    );
  }

  Widget _buildExercisesList() {
    return widget.workoutController.type == workoutType.tabata
        ? Expanded(
            child: ExercisesListModal(
              workoutController: widget.workoutController,
              callback: () {
                setState(() {
                  _changeOccurred = true;
                });
              },
            ),
          )
        : SizedBox();
  }

  Widget _buildTooltip() {
    return widget.workoutController.type == workoutType.tabata
        ? Center(
            child: Text(
            AppLocalizations.exerciseListHint,
            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: AppTheme.dynamicColor()),
            textAlign: TextAlign.center,
          ))
        : SizedBox();
  }

  Widget _buildPunctuation(String value) {
    return widget.workoutController.type == workoutType.tabata
        ? Text(
            value,
            style: TextStyle(
                color: Theme.of(Get.context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        : SizedBox();
  }

  void _setState() {
    var settings = new WorkoutSettingsModel(
        _rounds, _restTime, _workTime, _canSkip, _maxDuration);
    debugPrint('skip ' + _canSkip.toString());

    if (widget.workoutController.type == workoutType.tabata) {
      AppStateHandler.setTabataSettings(settings);
    } else {
      AppStateHandler.setHiitSettings(settings);
    }

    widget.workoutController.setSettings(settings);
  }
}
