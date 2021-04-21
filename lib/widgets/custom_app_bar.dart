import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppBar {
  static PreferredSizeWidget buildWithActions(List<Widget> actions,
          {double elevation = 0.0, String text = '', double iconSize = 24}) {

    return AppBar(
      backgroundColor: Theme.of(Get.context).canvasColor,
      elevation: elevation,
      iconTheme: IconThemeData(
          color: Theme.of(Get.context).accentColor,
          size: iconSize),
      actions: actions,
      title: Text(
        text.toUpperCase(),
        style: AppTheme.appBarStyle(),
      ),
      centerTitle: true,
    );
  }

  static PreferredSizeWidget buildRest(List<Widget> actions,
          {double elevation = 0.0,
          String text = '',
          double iconSize = 24,
          bool hideLeading = false}) =>
      AppBar(
        backgroundColor:
        AppTheme.countDownTimerColor(),
        elevation: elevation,
        actions: actions,
        leading: new Container(),
        title: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 34, color: Colors.red),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildCountDown(
      {double elevation = 0.0,
        String text = '',
        double iconSize = 24,
        bool hideLeading = false}) =>
      AppBar(
        backgroundColor:
        AppTheme.countDownTimerColor(),
        elevation: elevation,
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
          text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 34, color: Colors.red),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildNormal(String text,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(Get.context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: Theme.of(Get.context).accentColor,
        ),
        title: Text(
          text.toUpperCase(),
          style: AppTheme.appBarStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildEmpty() => AppBar(
        backgroundColor: Theme.of(Get.context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(Get.context).accentColor,
        ),
        centerTitle: false,
      );

  static PreferredSizeWidget buildCardsScreen() => AppBar(
        backgroundColor: Theme.of(Get.context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(Get.context).accentColor,
        ),
        actions: [
          IconButton(icon: Icon(Icons.dashboard_customize), onPressed: null)
        ],
        centerTitle: false,
      );

  static PreferredSizeWidget buildTimer(
          int elapsedMilliseconds, Function callback, bool isInRest) =>
      AppBar(
        title: Text(Utils.formatTime(elapsedMilliseconds),
            style: TextStyle(
              color: Colors.red,
              fontSize: 60,
              fontFamily: 'digital',
            ),
            textAlign: TextAlign.center),
        centerTitle: true,
        leading: new Container(),
        backgroundColor: isInRest ? AppTheme.countDownTimerColor() : Theme.of(Get.context).canvasColor,
        elevation: 0,
        actions: [
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.times,
                color: Colors.red,
                size: 35,
              ),
              onPressed: callback)
        ],
        automaticallyImplyLeading: true,
      );
}
