import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar buildFeedAppBar(BuildContext context, String text,
      {double elevation = 0.5}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: null)
        ],
        title: Text(
          text,
          style: AppTheme.appBarDarkStyle(),
        ),
        centerTitle: true,
      );

  static AppBar buildNormal(BuildContext context, String text,
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

  static AppBar buildEmpty(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        centerTitle: false,
      );

  static AppBar buildEmptyNoBack(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: new Container(),
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
        ),
        centerTitle: false,
      );
}
