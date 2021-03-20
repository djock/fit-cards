import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/screens/tutorial_cards_screen.dart';
import 'package:fitcards/screens/workouts_log_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/custom_button.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildWithActions(
          context, [IconButton(icon: Icon(Icons.settings), onPressed: null)],
          text: AppLocalizations.appName),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                buttonColor: AppColors.mandarin,
                onPressed: () {
                  AppStateHandler.shuffleJson();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TutorialCardsScreen()));
                },
                textColor: AppColors.mainGrey,
                isOutline: false,
                isRequest: false,
                buttonText: AppLocalizations.startAWorkout,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonColor: AppColors.mandarin,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutsLogScreen()));
                },
                textColor: AppColors.mainGrey,
                isOutline: false,
                isRequest: false,
                buttonText: AppLocalizations.workoutsLog,
              )
            ],
          ),
        ),
      ),
    );
  }
}
