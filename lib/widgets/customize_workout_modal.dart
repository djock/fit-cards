import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/handlers/workout_state.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomizeWorkoutModal extends StatefulWidget {
  final WorkoutController workoutController;

  const CustomizeWorkoutModal({Key key, this.workoutController}) : super(key: key);

  @override
  _CustomizeWorkoutModal createState() => _CustomizeWorkoutModal();
}

class _CustomizeWorkoutModal extends State<CustomizeWorkoutModal> {
  int _restTime = 10;
  int _workTime = 10;

  int _rounds = 8;
  int _maxDuration = 0;

  bool _canSkip = false;
  bool _changeOccurred = false;

  @override
  void initState() {
    _restTime = WorkoutState.restTime;
    _canSkip = WorkoutState.canSkipExercise;
    _changeOccurred = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        AppLocalizations.customize,
        textAlign: TextAlign.center,
        style: AppTheme.customAccentText(FontWeight.bold, 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Theme(
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
                  widget.workoutController.setState(workoutState.active);

                  _changeOccurred = true;
                  _canSkip = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.chooseRestTime,
                  style: AppTheme.customAccentText(FontWeight.normal, 14),
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              NumberPicker(
                value: _restTime,
                haptics: true,
                minValue: 5,
                maxValue: 90,
                itemCount: 3,
                step: 5,
                itemHeight: 30,
                itemWidth: 30,
                textStyle: AppTheme.customAccentText(FontWeight.normal, 13),
                selectedTextStyle:
                    AppTheme.textAccentBold15(),
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
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            UserPreferencesHandler.saveWorkoutRestTime(_restTime);
            UserPreferencesHandler.saveWorkoutExerciseSkip(_canSkip);

            var settings = new WorkoutSettingsModel(_rounds, _restTime, _workTime, _canSkip, _maxDuration);
            widget.workoutController.setSettings(settings);

            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.close,
            style: AppTheme.textAccentBold15(),
          ),
        ),
      ],
    );
  }
}
