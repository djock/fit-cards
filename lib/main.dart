import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitcards/app.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/firebase_database_handler.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

void main() async {
  HiveHandler.init();
  WidgetsFlutterBinding.ensureInitialized();

  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);

  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously().then((value) {
    FirebaseDatabaseHandler.user = value.user.uid;
  });

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _setAppVersion();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitCards',
      theme: appThemeLight(),
      darkTheme: appThemeDark(),
      home: App(),
    );
  }

  void _setAppVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      AppState.appVersion = packageInfo.version;
      AppState.appBuildNumber = int.parse(packageInfo.buildNumber);
    });
  }
}
