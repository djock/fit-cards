import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/leaderboard_screen.dart';
import 'package:fitcards/screens/stats_screen.dart';
import 'package:fitcards/screens/workout_screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [_buildHeader(), _buildButtons()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Text(
              '${AppState.points} points',
              style: AppTheme.textAccentBold30(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        style: AppTheme.customAccentText(FontWeight.normal, 12),
                      ),
                      Text(
                        'Lvl. 1',
                        style: AppTheme.customAccentText(FontWeight.normal, 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    minHeight: 7,
                    value: 0.5,
                    backgroundColor:
                        Theme.of(Get.context).accentColor.withOpacity(0.5),
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
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
          SizedBox(
            height: 20,
          ),
          _buildSectionListItem(AppLocalizations.statistics,
              FontAwesomeIcons.trophy, FontAwesomeIcons.chevronRight, () {
            Get.to(() => StatsScreen());
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
