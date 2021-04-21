import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/models/exercise_model.dart';
import 'package:fitcards/models/scheme_model.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/fit_card.dart';
import 'package:fitcards/widgets/flutter_tindercard.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SettingsThemeScreen extends StatefulWidget {
  @override
  _SettingsThemeScreenState createState() => _SettingsThemeScreenState();
}

class _SettingsThemeScreenState extends State<SettingsThemeScreen> {

  List<ExerciseModel> _exercises = [];
  List<SchemeModel> _schemes = [];

  var _dummyExercise = new ExerciseModel(name: AppLocalizations.exercise, id: -1, points: 0);
  var _dummyScheme = new SchemeModel(name: AppLocalizations.scheme, id: -1, type: schemeType.reps );

  @override
  Widget build(BuildContext context) {
    _exercises.add(_dummyExercise);
    _exercises.add(_dummyExercise);
    _exercises.add(_dummyExercise);
    _schemes.add(_dummyScheme);
    _schemes.add(_dummyScheme);
    _schemes.add(_dummyScheme);

    return SafeScreen(
      appBar: CustomAppBar.buildEmpty(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _buildSectionListItem(
                  AppLocalizations.nightMode,
                  FontAwesomeIcons.adjust,
                  Get.isDarkMode
                      ? FontAwesomeIcons.toggleOn
                      : FontAwesomeIcons.toggleOff, () {
                AppTheme.changeTheme();
              }),
            ),
            Expanded(
              flex: 4,
              child: FitCard(
                cardController: new CardController(),
                list: _exercises,
                color: AppColors.exerciseCardColor,
                isBlocked: true,
                type: cardType.exercise,
                onCallback: () {},
                onSkip: () {},
                isFake: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 4,
              child: FitCard(
                key: new GlobalKey(),
                cardController: new CardController(),
                list: _schemes,
                color: AppColors.schemeCardColor,
                isBlocked: true,
                type: cardType.scheme,
                onCallback: () {},
                isFake: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
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
          style: AppTheme.textAccentNormal15(),
        ),
        leading: leftIcon != null
            ? _buildIcon(leftIcon, AppTheme.dynamicColor())
            : SizedBox(),
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

