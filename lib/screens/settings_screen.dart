import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/screens/settings_theme_screen.dart';
import 'package:fitcards/screens/welcome_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/action_list_item.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final Function callback;

  const SettingsScreen({Key? key, required this.callback}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: CustomAppBar.buildEmpty(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 48,
                left: 8,
                right: 8), // EdgeInsets.symmetric(vertical: 8.0)
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildSectionHeader(AppLocalizations.settings),
//                          _buildSectionListItem(
//                              AppLocalizations.nightMode,
//                              FontAwesomeIcons.adjust,
//                              Get.isDarkMode
//                                  ? FontAwesomeIcons.toggleOn
//                                  : FontAwesomeIcons.toggleOff, () {
//                            AppTheme.changeTheme();
//
//                            Future.delayed(Duration(seconds: 2), () {
//                              setState(() {
//
//                              });
//                            });
//                          }),
                          IconListItem(
                              text: AppLocalizations.appTheme,
                              leftIcon: FontAwesomeIcons.adjust,
                              rightIcon: FontAwesomeIcons.chevronRight,
                              function: () {
                                Get.to(() => SettingsThemeScreen())!
                                    .then((value) {
                                  widget.callback();
                                  setState(() {});
                                });
                              }),
                          Divider(
                            height: 3,
                          ),
                          IconListItem(
                              text: AppLocalizations.audio,
                              leftIcon: FontAwesomeIcons.trophy,
                              rightIcon: AppState.audioEnabled
                                  ? FontAwesomeIcons.toggleOn
                                  : FontAwesomeIcons.toggleOff,
                              function: () {
                                setState(() {
                                  UserPreferencesHandler.saveAudioEnabled(
                                      !AppState.audioEnabled);
                                });
                              }),
                          Divider(
                            height: 3,
                          ),
                          IconListItem(
                              text: AppLocalizations.sendFeedback,
                              leftIcon: FontAwesomeIcons.comment,
                              rightIcon: FontAwesomeIcons.externalLinkAlt,
                              function: () {
                                _launchURL(
                                    'mailto:fit.cards.app@gmail.com?subject=Fit%20Cards%20App%20Feedback');
                              }),
                          Divider(
                            height: 3,
                          ),
                          IconListItem(
                              text: AppLocalizations.clearAllData,
                              leftIcon: FontAwesomeIcons.exclamationTriangle,
                              rightIcon: FontAwesomeIcons.trash,
                              function: () {
                                _clearAllData();
                              }),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          _buildAppInfo(),
        ],
      ),
      topSafe: false,
//      body: SingleChildScrollView(
//          child: ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
        padding: EdgeInsets.only(left: 24, top: 16),
        height: 60,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: TextStyle(
                    color: AppTheme.dynamicColor(),
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold))));
  }

  Widget _buildAppInfo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          'FitCards v${AppState.appVersion}+${AppState.appBuildNumber}',
          style: TextStyle(
              fontSize: 11, color: AppTheme.dynamicColor(), letterSpacing: 1),
        ),
      ),
    );
  }

  void _clearAllData() {
    showDialog(
        context: context,
        builder: (context) => GeneralModal(
              subTitle: AppLocalizations.clearAllDataSubtitle,
              okAction: () {
                Get.off(() => WelcomeScreen());
                Get.changeThemeMode(ThemeMode.system);
                AppStateHandler.clearAllData();
              },
              cancelAction: () => Get.back(),
              okActionText: AppLocalizations.close,
              cancelActionText: AppLocalizations.cancel,
              title: '',
            ));
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
