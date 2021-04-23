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

//    loadTutorialFinishedPrefs();

    loadAudioEnabled();
    loadPoints();
  }
//
//  static Future<void> markTutorialAsFinished() async {
//    final SharedPreferences prefs = await _sharedPreferences;
//    prefs.setBool('tutorialFinished', true);
//
//    AppState.tutorialActive = false;
//    AppState.tutorialFinished = true;
//  }
//
//  static Future<void> loadTutorialFinishedPrefs() async {
//    final SharedPreferences prefs = await _sharedPreferences;
//    AppState.tutorialFinished = prefs.getBool('tutorialFinished') != null
//        ? prefs.getBool('tutorialFinished')
//        : false;
//  }

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

  static Future<void> saveAudioEnabled(bool value) async {
    final SharedPreferences prefs = await _sharedPreferences;

    AppState.audioEnabled = value;
    prefs.setBool('audioEnabled', value);
  }

  static Future loadAudioEnabled() async {
    final SharedPreferences prefs = await _sharedPreferences;
    bool audioEnabled = true;

    if(prefs.getBool('audioEnabled') != null) {
      audioEnabled = prefs.getBool('audioEnabled');
    }

    AppState.audioEnabled = audioEnabled;
  }

  static Future<void> savePoints() async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setInt('points', AppState.points);
  }

  static Future loadPoints() async {
    final SharedPreferences prefs = await _sharedPreferences;
    int points = 0;

    if(prefs.getInt('points') != null) {
      points = prefs.getInt('points');
    }

    AppState.points = points;
  }

  static Future clearAllData() async {
    final SharedPreferences prefs = await _sharedPreferences;
    await prefs.clear();
  }
 }
