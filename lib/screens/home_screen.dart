import 'dart:async';

import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/cards_screen.dart';
import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/settings_screen.dart';
import 'package:fitcards/screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_gradient_button.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() {
    return showDialog(
            context: context,
            builder: (context) => GeneralModal(
                  subTitle: AppLocalizations.closeAppSubtitle,
                  okAction: () => SystemNavigator.pop(),
                  cancelAction: () => Navigator.pop(context),
                  okActionText: AppLocalizations.close,
                  cancelActionText: AppLocalizations.cancel,
                )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeScreen(
          topSafe: false,
            appBar: CustomAppBar.buildEmpty(),
//          appBar: CustomAppBar.buildWithActions([
//            IconButton(
//                icon: FaIcon(FontAwesomeIcons.cog),
//                color: Theme.of(Get.context).accentColor,
//                onPressed: () {
//                  Get.to(() => SettingsScreen()).then((value) {
//                    setState(() {});
//                  });
//                })
//          ], elevation: 0, text: ''),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildButtons()),
              ],
            ),
          ),
        ));
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.hello} ${AppState.userName},',
                  style: AppTheme.textAccentBold30(),
                  maxLines: 2,
                ),
                SizedBox(
                  height: AppState.points != 0 ? 5 : 0,
                ),
                AppState.points != 0
                    ? Text(
                        '+${AppState.points} points',
                        style: AppTheme.textAccentBold30(),
                      )
                    : SizedBox(),
                SizedBox(
                  height: AppState.points != 0 ? 5 : 0,
                ),
                Text(
                  AppLocalizations.areYouReady,
                  style: AppTheme.textAccentNormal15(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          CustomGradientButton(
            text: AppLocalizations.shuffleCards,
            icon: FontAwesomeIcons.random,
            action: () {
              AppStateHandler.shuffleJson();
              Get.to(() => CardsScreen()).then((value) {
                setState(() {});
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomGradientButton(
            text: AppLocalizations.tabata,
            icon: FontAwesomeIcons.clock,
            action: () {
              AppStateHandler.shuffleJson();
              Get.to(() => CardsScreen()).then((value) {
                setState(() {});
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomGradientButton(
            text: AppLocalizations.forTime,
            icon: FontAwesomeIcons.hourglassHalf,
            action: () {
              AppStateHandler.shuffleJson();
              Get.to(() => CardsScreen()).then((value) {
                setState(() {});
              });
            },
          ),
//          SizedBox(
//            height: 20,
//          ),
//          CustomGradientButton(
//            text: AppLocalizations.workoutsLog,
//            icon: FontAwesomeIcons.calendarAlt,
//            action: () {
//              Get.to(() => WorkoutsLogScreen());
//            },
//          ),
//          SizedBox(
//            height: 20,
//          ),
//          CustomGradientButton(
//            text: AppLocalizations.leaderBoard,
//            icon: FontAwesomeIcons.trophy,
//            action: () {
//              Get.to(() => LeaderBoardScreen());
//            },
//          ),
        ],
      ),
    );
  }
}
