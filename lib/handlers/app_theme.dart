import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/app_colors.dart';

ThemeData appThemeDark() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.accentColor,
      accentColor: AppColors.accentColor,
      canvasColor: AppColors.canvasColorDark,
      primaryColorDark: AppColors.canvasColorDark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      fontFamily: 'Roboto',
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontFamily: 'Roboto'),
        bodyText1:
            TextStyle(fontFamily: 'Roboto', color: AppColors.canvasColorDark),
      ),
    );

ThemeData appThemeLight() => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.accentColor,
      accentColor: AppColors.accentColor,
      canvasColor: AppColors.canvasColorLight,
      primaryColorDark: AppColors.canvasColorDark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      fontFamily: 'Roboto',
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontFamily: 'Roboto'),
        bodyText1:
            TextStyle(fontFamily: 'Roboto', color: AppColors.canvasColorLight),
      ),
    );

class AppTheme {
  static TextStyle appBarStyle() {
    return _textStyle(22, FontWeight.bold, dynamicColor());
  }

  static TextStyle textWhiteBold24() {
    return _textStyle(
        24, FontWeight.bold, Theme.of(Get.context).textTheme.bodyText1.color);
  }

  static TextStyle textAccentNormal15() {
    return _textStyle(15, FontWeight.normal, dynamicColor());
  }

  static TextStyle textAccentBold15() {
    return _textStyle(15, FontWeight.bold, dynamicColor());
  }

  static TextStyle textAccentBold30() {
    return _textStyle(30, FontWeight.bold, dynamicColor());
  }

  static TextStyle customAccentText(FontWeight fontWeight, double fontSize) {
    return _textStyle(fontSize, fontWeight, dynamicColor());
  }

  static TextStyle _textStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
        color: color,
        letterSpacing: 1.3,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  static void changeTheme() {
    var darkMode = false;

    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      darkMode = true;
      Get.changeThemeMode(ThemeMode.dark);
    }

    UserPreferencesHandler.savePreferredTheme(darkMode);
  }

  static void setTheme(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
  }

  static Color dynamicColor() =>
      Get.isDarkMode ? Colors.white : Colors.black;

  static Color appBarColor() =>  Get.context.isDarkMode ? AppColors.barColorDark : AppColors.barColorLight;

  static Color widgetBackground() =>  Get.isDarkMode ? AppColors.widgetColorDark : AppColors.widgetColorLight;
}
