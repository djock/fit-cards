import 'package:fitcards/screens/cards_screen.dart';
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
      appBar: CustomAppBar.buildFeedAppBar(context, AppLocalizations.appName),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CardsScreen()));
                },
                textColor: AppColors.mainGrey,
                isOutline: false,
                isRequest: false,
                buttonText: 'Start A Workout',
              ),
              SizedBox(height: 20,),
              CustomButton(
                buttonColor: AppColors.mandarin,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkoutsLogScreen()));
                },
                textColor: AppColors.mainGrey,
                isOutline: false,
                isRequest: false,
                buttonText: 'Workouts Log',
              )
            ],
          ),
        ),
      ),
    );
  }
}
