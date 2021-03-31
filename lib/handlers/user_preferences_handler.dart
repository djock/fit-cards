import 'package:fitcards/handlers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesHandler {
  static int preferredTrainDuration;
  static int preferredBreakDuration;
  static bool preferredTheme;
  static String userName;

  static Future<SharedPreferences> _sharedPreferences;

  static void initSharedPreferences() {
    _sharedPreferences = SharedPreferences.getInstance();

    loadTutorialFinishedPrefs();
  }

  static Future<void> markTutorialAsFinished() async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setBool('tutorialFinished', true);

    AppState.tutorialFinished = true;
  }

  static Future<void> loadTutorialFinishedPrefs() async {
    final SharedPreferences prefs = await _sharedPreferences;
    AppState.tutorialFinished = prefs.getBool('tutorialFinished') != null
        ? prefs.getBool('tutorialFinished')
        : false;
  }

  static Future<void> saveUserName(String userName) async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setString('userName', userName);

    AppState.userName = userName;
  }

  static Future<bool> loadUserName() async {
    final SharedPreferences prefs = await _sharedPreferences;

    AppState.userName = prefs.getString('userName') != null
        ? prefs.getString('userName')
        : '';

    return AppState.userName.isNotEmpty;
  }


  static Future<void> savePreferredTheme(bool isDarkMode) async {
    final SharedPreferences prefs = await _sharedPreferences;
    debugPrint('theme ' + isDarkMode.toString());
    prefs.setBool('theme', isDarkMode);
  }

  static Future<ThemeMode> loadPreferredTheme() async {
    final SharedPreferences prefs = await _sharedPreferences;

    if(prefs.getBool('theme') != null) {
      return prefs.getBool('theme') ? ThemeMode.dark : ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
