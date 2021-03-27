import 'package:fitcards/handlers/hive_handler.dart';
import 'package:fitcards/screens/home_screen.dart';
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

  @override
  void initState() {
    JsonDataHandler.loadAppData().then((value) => {
      if(this.mounted) {
        setState(() {
          _hasLoadedData = true;
        })
      }
    });

    HiveHandler.openHiveBoxes();
    UserPreferencesHandler.initSharedPreferences();
    UserPreferencesHandler.loadUserName().then((value) {
      if(value) {
        setState(() {
          debugPrint('state '  + value.toString());
          _userNameSet = value;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_hasLoadedData ' + _hasLoadedData.toString());
    debugPrint('_userNameSet ' + _userNameSet.toString());

    return _hasLoadedData
        ? _userNameSet ? HomeScreen() : WelcomeScreen()
        : LoadingScreen();
  }
}
