import 'package:fitcards/utilities/utils.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/cupertino.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar:  Utils.buildAppBar(context, 'Workouts Log'),
      body: Container(),
    );
  }
}