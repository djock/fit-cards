import 'package:fitcards/app.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  HiveHandler.init();

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitCards',
      theme: appTheme(),
      home: App(),
    );
  }
}