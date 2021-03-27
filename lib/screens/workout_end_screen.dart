import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class WorkoutEndScreen extends StatelessWidget {
  final Function callback;

  const WorkoutEndScreen({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: null,
      body: Container(
        child: InkWell(
          onTap: () {
            callback();
            Navigator.pop(context);
          },
          child: Container(
            color: AppColors.accentColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.tutorialFinishDescription,
                    textAlign: TextAlign.center,
                    style:
                    AppTheme.customText(FontWeight.normal, 24),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    AppLocalizations.tapToClose,
                    textAlign: TextAlign.center,
                    style:
                    AppTheme.customText(FontWeight.normal, 24),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}