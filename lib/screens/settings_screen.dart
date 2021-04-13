import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/user_preferences_handler.dart';
import 'package:fitcards/screens/settings_theme_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  final Function callback;

  const SettingsScreen({Key key, this.callback}) : super(key: key);

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
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
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
                          _buildSectionListItem(
                              AppLocalizations.appTheme,
                              FontAwesomeIcons.adjust,
                              null, () {
                            Get.to(() => SettingsThemeScreen()).then((value) {
                              debugPrint('test');
                              widget.callback();
                              setState(() {});
                            });
                          }),
                          Divider(
                            height: 3,
                          ),
                          _buildSectionListItem(
                              AppLocalizations.audio,
                              FontAwesomeIcons.volumeUp,
                              AppState.audioEnabled
                                  ? FontAwesomeIcons.toggleOn
                                  : FontAwesomeIcons.toggleOff, () {
                            setState(() {
                              UserPreferencesHandler.saveAudioEnabled(
                                  !AppState.audioEnabled);
                            });
                          }),
                          Divider(
                            height: 3,
                          ),
                          _buildSectionListItem(
                              AppLocalizations.clearAllData,
                              FontAwesomeIcons.exclamationTriangle,
                              FontAwesomeIcons.trash, () {
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
//      body: SingleChildScrollView(
//          child: ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 13),
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

  Widget _buildSectionListItem(
      String text, IconData leftIcon, IconData rightIcon, Function function) {
    return Container(
      color: Theme.of(Get.context).canvasColor,
      child: ListTile(
        onTap: () {
          if (function != null) {
            function();
          }
        },
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        title: Text(
          text,
          style: AppTheme.customDynamicText(FontWeight.normal, 15),
        ),
        leading: _buildIcon(leftIcon, AppTheme.dynamicColor()),
        trailing: rightIcon != null ? _buildIcon(rightIcon, AppTheme.dynamicColor()) : SizedBox(),
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: FaIcon(
        icon,
        color: color,
      ),
    );
  }

  Widget _buildAppInfo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          'v${AppState.appVersion}+${AppState.appBuildNumber}',
          style: TextStyle(fontSize: 11, color: AppTheme.dynamicColor()),
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
              cancelAction: () => Navigator.pop(context),
              okActionText: AppLocalizations.close,
              cancelActionText: AppLocalizations.cancel,
            ));
  }
}
