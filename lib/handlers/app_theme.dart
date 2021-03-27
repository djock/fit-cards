import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/app_colors.dart';

ThemeData appThemeDark() => ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColorDark,
  accentColor: AppColors.accentColor,
  canvasColor: AppColors.canvasColorDark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
  ),

  fontFamily: 'Roboto',
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,

  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontFamily: 'Roboto'),
    bodyText1: TextStyle(fontFamily: 'Roboto', color: Colors.white),
  ),
);

ThemeData appThemeLight() => ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColorLight,
  accentColor: AppColors.accentColor,
  canvasColor: AppColors.canvasColorLight,
  primaryColorDark: AppColors.canvasColorDark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
  ),

  fontFamily: 'Roboto',
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,

  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle( fontFamily: 'Roboto'),
    bodyText1: TextStyle(fontFamily: 'Roboto', color: Colors.black),
  ),
);

class AppTheme {

  static TextStyle appBarStyle() {
    return _textStyle(22, FontWeight.bold, Get.isDarkMode ? Theme.of(Get.context).accentColor : AppColors.canvasColorDark);
  }
  static TextStyle textWhiteBold24() {
    return _textStyle(24, FontWeight.bold, AppColors.textColor);
  }

  static TextStyle textAccentBold30() {
    return _textStyle(30, FontWeight.bold, Theme.of(Get.context).accentColor);
  }

  static TextStyle textAccentNormal15() {
    return _textStyle(15, FontWeight.normal, Theme.of(Get.context).accentColor);
  }

  static TextStyle textThemeBold15() {
    return _textStyle(14, FontWeight.bold, Get.isDarkMode ? Theme.of(Get.context).accentColor : AppColors.canvasColorDark);
  }

  static TextStyle customText(FontWeight fontWeight, double fontSize) {
    return _textStyle(fontSize, fontWeight, AppColors.textColor);
  }

  static TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color){
    return TextStyle(
        color: color,
        letterSpacing: 1,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  static void changeTheme() {
    if(Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}
