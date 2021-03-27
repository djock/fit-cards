import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static PreferredSizeWidget buildWithActions(BuildContext context, List<Widget> actions,
      {double elevation = 0.5, String text = ''}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        actions: actions,
        title: Text(
          text,
          style: AppTheme.appBarDarkStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildNormal(BuildContext context, String text,
      {double elevation = 0.5}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        title: Text(
          text,
          style: AppTheme.appBarDarkStyle(),
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildEmpty(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        centerTitle: false,
      );

  static PreferredSizeWidget buildCardsScreen(BuildContext context) => AppBar(
    backgroundColor: Theme.of(context).canvasColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.mainColor,
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
    backgroundColor: Colors.black,
    elevation: 0,
    actions: [
      IconButton(icon: Icon(Icons.close, color: Colors.red, size: 35,), onPressed: callback)
    ],
    automaticallyImplyLeading: true,
  );
}
