import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:fitcards/app.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/hive_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

void main() async {
  HiveHandler.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Main());
}

class Main extends StatelessWidget {
  static final facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    facebookAppEvents.setAdvertiserTracking(enabled: true);

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
