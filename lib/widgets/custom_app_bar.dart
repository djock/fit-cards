import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAppBar {
  static PreferredSizeWidget buildWithActions(BuildContext context, List<Widget> actions,
      {double elevation = 0.0, String text = '', double iconSize = 24}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Theme.of(Get.context).accentColor : Theme.of(Get.context).primaryColorDark,
          size: iconSize
        ),
        actions: actions,
        title: Text(
          text,
          style: AppTheme.appBarStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildNormal(BuildContext context, String text,
      {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Theme.of(Get.context).accentColor : Theme.of(Get.context).primaryColorDark,
        ),
        title: Text(
          text,
          style: AppTheme.appBarStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildEmpty(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Theme.of(Get.context).accentColor : Theme.of(Get.context).primaryColorDark,
        ),
        centerTitle: false,
      );

  static PreferredSizeWidget buildCardsScreen(BuildContext context) => AppBar(
    backgroundColor: Theme.of(context).canvasColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Get.isDarkMode ? Theme.of(Get.context).accentColor : Theme.of(Get.context).primaryColorDark,
    ),
    actions: [
      IconButton(icon: Icon(Icons.dashboard_customize), onPressed: null)
    ],
    centerTitle: false,
  );

  static PreferredSizeWidget buildTimer(int elapsedMilliseconds, Function callback) => AppBar(
    title: Text(Utils.formatTime(elapsedMilliseconds),
        style: TextStyle(
          color: Colors.red,
          fontSize: 60,
          fontFamily: 'digital',
        ),
        textAlign: TextAlign.center),
    centerTitle: true,
    leading: new Container(),
    backgroundColor: Theme.of(Get.context).canvasColor,
    elevation: 0,
    actions: [
      IconButton(icon: FaIcon(FontAwesomeIcons.times, color: Colors.red, size: 35,), onPressed: callback)
    ],
    automaticallyImplyLeading: true,
  );
}
