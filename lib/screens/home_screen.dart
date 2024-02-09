import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/stats_screen.dart';
import 'package:fitcards/screens/workout_screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/action_list_item.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildEmpty(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [_buildHeader(), _buildButtons()],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.widgetBackground(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
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
                Text(
                  '${AppState.points} ${AppLocalizations.points}',
                  style: AppTheme.textAccentBold30(),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   height: 40,
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             '',
                //             style: AppTheme.customAccentText(FontWeight.normal, 12),
                //           ),
                //           Text(
                //             'Lvl. 1',
                //             style: AppTheme.customAccentText(FontWeight.normal, 12),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       LinearProgressIndicator(
                //         minHeight: 7,
                //         value: 0.5,
                //         backgroundColor:
                //             Theme.of(Get.context!).primaryColor.withOpacity(0.5),
                //         semanticsLabel: 'Linear progress indicator',
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
          SizedBox(
            height: 20,
          ),
          IconListItem(
              text: AppLocalizations.statistics,
              leftIcon: FontAwesomeIcons.chartBar,
              rightIcon: FontAwesomeIcons.chevronRight,
              function: () {
                Get.to(() => StatsScreen());
              }),
        ],
      ),
    );
  }
}
