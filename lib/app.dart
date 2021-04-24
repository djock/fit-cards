import 'dart:async';

import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/screens/app_screen.dart';
import 'package:fitcards/screens/loading_screen.dart';
import 'package:fitcards/utilities/json_data_handler.dart';
import 'package:fitcards/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'handlers/user_preferences_handler.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _hasLoadedData = false;
  bool _userNameSet = false;
  bool _themeSet = false;

  bool _isAppLoading = true;

  Future<Null> _startLoadingCountdown() async {
    const timeOut = const Duration(seconds: 2);
    new Timer(timeOut, () {
      setState(() => _isAppLoading = false);
    });
  }

  @override
  void initState() {
    _startLoadingCountdown();
    JsonDataHandler.loadAppData().then((value) => {
          if (this.mounted)
            {
              setState(() {
                _hasLoadedData = true;
              })
            }
        });

    HiveHandler.openHiveBoxes();
    UserPreferencesHandler.initSharedPreferences();
    UserPreferencesHandler.loadUserName().then((value) {
      if (value) {
        setState(() {
          _userNameSet = value;
        });
      }
    });

    UserPreferencesHandler.loadPreferredTheme().then((value) {
      if (this.mounted) {
        setState(() {
          AppTheme.setTheme(value);
          _themeSet = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _hasLoadedData && _themeSet && !_isAppLoading
        ? _userNameSet
            ? AppScreen()
            : WelcomeScreen()
        : LoadingScreen();
  }
}
