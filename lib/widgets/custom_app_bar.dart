import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/workout_controller.dart';
import 'package:fitcards/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppBar {
  static PreferredSizeWidget buildWithActions(List<Widget> actions,
      {double elevation = 0.0, String text = '', double iconSize = 24}) {
    return AppBar(
      backgroundColor: AppTheme.appBarColor(),
      elevation: elevation,
      iconTheme: IconThemeData(color: AppTheme.dynamicColor(), size: iconSize),
      actions: actions,
      title: Text(
        text.toUpperCase(),
        style: AppTheme.appBarStyle(),
      ),
      centerTitle: true,
    );
  }

  static PreferredSizeWidget buildNormal(String text,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: AppTheme.appBarColor(),
        elevation: elevation,
        iconTheme: IconThemeData(
          color: AppTheme.dynamicColor(),
        ),
        title: Text(
          text.toUpperCase(),
          style: AppTheme.appBarStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWorkoutIdle(String text,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 34, color: Colors.red),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWorkoutActive(
          String text, Function callback) =>
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 34, color: Colors.red),
        ),
        leading: Container(),
        actions: [
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.times,
                color: Colors.red,
                size: 40,
              ),
              onPressed: () => callback)
        ],
        centerTitle: true,
      );

  static PreferredSizeWidget buildEmpty() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppTheme.dynamicColor(),
        ),
        centerTitle: false,
      );

  static PreferredSizeWidget buildWorkout(
          int duration,
          timerType timerType,
          Function? timerCallback,
          Function buttonCallback,
          WorkoutController workoutController) =>
      AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: new Container(),
        actions: [
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.times,
                color: Colors.red,
                size: 35,
              ),
              onPressed: () => buttonCallback)
        ],
        flexibleSpace: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TimerWidget(
                  duration: duration,
                  callback: () {
                    timerCallback!();
                  },
                  type: timerType,
                  workoutController: workoutController,
                ),
              ),
            ],
          ),
        ),
      );
}
