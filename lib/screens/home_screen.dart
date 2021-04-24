import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/workout_screens/workout_screen.dart';
import 'package:fitcards/screens/workout_screens/workout_tabata_screen.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_gradient_button.dart';
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [_buildHeader(), _buildButtons()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        CustomGradientButton(
          text: AppLocalizations.hiit,
          icon: FontAwesomeIcons.random,
          action: () {
            AppStateHandler.shuffleJson();
            Get.to(() => WorkoutScreen()).then((value) {
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
            Get.to(() => WorkoutTabataScreen()).then((value) {
              setState(() {});
            });
          },
        ),
      ],
    );
  }
}
