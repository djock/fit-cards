import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/workout_screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
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
          _buildSectionListItem(AppLocalizations.workoutsLog,
              FontAwesomeIcons.calendarAlt, FontAwesomeIcons.chevronRight, () {
            Get.to(() => WorkoutsLogScreen());
          }),
          SizedBox(
            height: 20,
          ),
          _buildSectionListItem(AppLocalizations.leaderBoard,
              FontAwesomeIcons.trophy, FontAwesomeIcons.chevronRight, () {
            Get.to(() => LeaderBoardScreen());
          }),
        ],
      ),
    );
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
          style: AppTheme.customAccentText(FontWeight.bold, 16),
        ),
        leading: _buildIcon(leftIcon, AppTheme.dynamicColor()),
        trailing: rightIcon != null
            ? _buildIcon(rightIcon, AppTheme.dynamicColor())
            : SizedBox(),
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
}
