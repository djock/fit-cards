import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/handlers/firebase_database_handler.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_app_bar.dart';
import 'package:fitcards/widgets/list_item.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  bool _hasLoaded = false;

  @override
  void initState() {
    FirebaseDatabaseHandler.getLeaderBoard().then((value) {
      setState(() {
        _hasLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: false,
      appBar: CustomAppBar.buildNormal(AppLocalizations.leaderBoard),
      body: _hasLoaded
          ? SingleChildScrollView(
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildLeaderBoard(),
              ),
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  List<Widget> _buildLeaderBoard() {
    List<Widget> _tempList = <Widget>[];

    if (FirebaseDatabaseHandler.leaderBoard.length > 0) {
      var index = 1;

      for (var entry in FirebaseDatabaseHandler.leaderBoard) {

        var deviceId = RegExp(r'^[^_]*_').stringMatch(entry.name);
        var userName = entry.name.replaceAll(deviceId, '');

        Color backgroundColor;

        if(index == 1) {
          backgroundColor = AppColors.goldColor.withOpacity(0.8);
        }else if(index ==2) {
          backgroundColor = AppColors.silverColor.withOpacity(0.8);
        } else if(index ==3) {
          backgroundColor = AppColors.bronzeColor.withOpacity(0.8);
        }

        _tempList.add(ListItem(
          leftValue: index.toString(),
          centerValue: userName,
          rightValue: entry.points.toString(),
          backgroundColor: backgroundColor,
        ));
        index++;
      }
    } else {
      _tempList.add(Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
        child: Text(
          AppLocalizations.nothingHere,
          style: AppTheme.customDynamicText(FontWeight.normal, 16),
          textAlign: TextAlign.center,
        ),
      )));
    }

    return _tempList;
  }
}