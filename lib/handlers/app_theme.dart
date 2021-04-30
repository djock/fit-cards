import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/app_colors.dart';

ThemeData appThemeDark() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColorDark,
      accentColor: AppColors.accentColorDark,
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
      primaryColor: AppColors.primaryColorLight,
      accentColor: AppColors.accentColorLight,
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

  static TextStyle customDarkText(FontWeight fontWeight, double fontSize) {
    return _textStyle(fontSize, fontWeight, AppColors.canvasColorDark);
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

  static Color countDownTimerColor() => Theme.of(Get.context)
      .primaryColorDark
      .withOpacity(Get.isDarkMode ? 0.6 : 0.85);

  static Color dynamicColor() =>
      Get.isDarkMode ? AppColors.colorWhite : Colors.black;

  static Color grey = Colors.grey.withOpacity(0.1);

  static Color navBarColor() =>  Get.isDarkMode ? Colors.grey.withOpacity(0.1) : Theme.of(Get.context).canvasColor;
}
