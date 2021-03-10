import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

ThemeData appTheme() {
  return new ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    accentColor: AppColors.mainColor,
    canvasColor: AppColors.mainGrey,
    floatingActionButtonTheme: FloatingActionButtonThemeData(

    ),

    // Define the default font family.
    fontFamily: 'Roboto',
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle( fontFamily: 'Roboto'),
    ),
  );
}

class AppTheme {

  static TextStyle appBarDarkStyle() {
    return _textStyle(22, FontWeight.bold, AppColors.mainColor);
  }
  static TextStyle headerLightStyle() {
    return _textStyle(20, FontWeight.bold, AppColors.textColor);
  }

  static TextStyle headerDarkStyle() {
    return _textStyle(20, FontWeight.bold, AppColors.mainColor);
  }

  static TextStyle mediumTextLightStyle() {
    return _textStyle(14, FontWeight.normal, AppColors.textColor);
  }

  static TextStyle mediumTextDarkStyle() {
    return _textStyle(14, FontWeight.normal, AppColors.mainColor);
  }

  static TextStyle mediumTextDarkBoldStyle() {
    return _textStyle(14, FontWeight.bold, AppColors.mainColor);
  }

  static TextStyle mediumTextGreyStyle() {
    return _textStyle(12, FontWeight.normal, Colors.grey.withOpacity(0.5));
  }

  static TextStyle smallTextLightStyle() {
    return _textStyle(12, FontWeight.normal, AppColors.textColor);
  }

  static TextStyle smallTextDarkStyle() {
    return _textStyle(12, FontWeight.normal, AppColors.mainColor);
  }

  static TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color){
    return TextStyle(
        color: color,
        letterSpacing: 1,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }
}
