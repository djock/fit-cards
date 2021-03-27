import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: AppColors.primaryColorLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Utils.getLoadingScreenText(), style: AppTheme.textAccentNormal15()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}