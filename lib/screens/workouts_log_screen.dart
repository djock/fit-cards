import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class WorkoutsLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar:  CustomAppBar.build(context, 'Workouts Log'),
      body: Container(),
    );
  }
}