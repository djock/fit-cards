import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/exercises_list_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomizeWorkoutModal extends StatefulWidget {
  final WorkoutController workoutController;
  final Function callback;

  const CustomizeWorkoutModal({Key key, this.workoutController, this.callback})
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
      padding: EdgeInsets.all(40),
      color: AppTheme.widgetBackground(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            mainAxisSize: MainAxisSize.min,
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
      }),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).accentColor),
      ),
    )
        : SizedBox();
  }

  Widget _buildDynamicRestSelector() {
  if(widget.workoutController.type == workoutType.tabata) {
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
        callback: () => setState(() {
          var dummyExercise = new ExerciseModel(
              name: AppLocalizations.exercise, id: -1, points: 0);
          widget.workoutController.exercises
              .insert(0, dummyExercise);
        }),
      ),
    )
        : SizedBox();
  }

  Widget _buildPunctuation(String value) {
    return widget.workoutController.type == workoutType.tabata ? Text(value, style: TextStyle(color: Theme.of(Get.context).accentColor, fontWeight: FontWeight.bold, fontSize: 20),) : SizedBox();
  }
}
