import 'package:fitcards/screens/home_screen.dart';
import 'package:fitcards/screens/loading_screen.dart';
import 'package:fitcards/utilities/json_data_handler.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool hasFinishedLoading = false;

  @override
  void initState() {
    JsonDataHandler.loadAppData().then((value) => {
      if(this.mounted) {
        setState(() {
          hasFinishedLoading = true;
        })
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return hasFinishedLoading
        ? HomeScreen()
        : LoadingScreen();
  }
}
