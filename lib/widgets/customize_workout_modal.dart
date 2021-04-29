import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/models/workout_settings_model.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 50),
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
                  _changeOccurred = true;
                  _canSkip = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          widget.workoutController.type == workoutType.tabata
              ? Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.rounds,
                        style: AppTheme.customAccentText(FontWeight.normal, 14),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    NumberPicker(
                      value: _rounds,
                      haptics: true,
                      minValue: 5,
                      maxValue: 30,
                      itemCount: 3,
                      step: 1,
                      itemHeight: 30,
                      itemWidth: 30,
                      textStyle:
                          AppTheme.customAccentText(FontWeight.normal, 13),
                      selectedTextStyle: AppTheme.textAccentBold15(),
                      axis: Axis.horizontal,
                      onChanged: (value) => setState(() {
                        _changeOccurred = true;
                        _rounds = value;
                      }),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          _buildDynamicSpace(),
          widget.workoutController.type == workoutType.tabata
              ? Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.chooseWorkTime,
                        style: AppTheme.customAccentText(FontWeight.normal, 14),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    NumberPicker(
                      key: new GlobalKey(),
                      value: _workTime,
                      haptics: true,
                      minValue: 5,
                      maxValue: 90,
                      itemCount: 3,
                      step: 5,
                      itemHeight: 30,
                      itemWidth: 30,
                      textStyle:
                          AppTheme.customAccentText(FontWeight.normal, 13),
                      selectedTextStyle: AppTheme.textAccentBold15(),
                      axis: Axis.horizontal,
                      onChanged: (value) => setState(() {
                        _changeOccurred = true;
                        _restTime = value;
                      }),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          _buildDynamicSpace(),
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
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            var settings = new WorkoutSettingsModel(
                _rounds, _restTime, _workTime, _canSkip, _maxDuration);

            if (widget.workoutController.type == workoutType.tabata) {
              AppState.tabataSettings = settings;
            } else {
              AppState.hiitSettings = settings;
            }

            widget.workoutController.setSettings(settings);
            if(widget.callback != null) widget.callback();

            Navigator.of(context).pop();
          },
          child: Text(
            _changeOccurred ? AppLocalizations.apply : AppLocalizations.close,
            style: AppTheme.textAccentBold15(),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicSpace() {
    return widget.workoutController.type == workoutType.tabata
        ? SizedBox(
            height: 20,
          )
        : SizedBox();
  }
}
