import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/workout_screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/action_list_item.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/stats_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: CustomAppBar.buildNormal(AppLocalizations.statistics),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: StatsTable(),
          ),
//          SizedBox(
//            height: 20,
//          ),
//          _buildButtons()
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          IconListItem(
              text: AppLocalizations.workoutsLog,
              leftIcon: FontAwesomeIcons.calendarAlt,
              rightIcon: FontAwesomeIcons.chevronRight,
              function: () {
                Get.to(() => WorkoutsLogScreen());
              }),
          SizedBox(
            height: 20,
          ),
          IconListItem(
              text: AppLocalizations.leaderBoard,
              leftIcon: FontAwesomeIcons.trophy,
              rightIcon: FontAwesomeIcons.chevronRight,
              function: () {
                Get.to(() => LeaderBoardScreen());
              }),
        ],
      ),
    );
  }
}
