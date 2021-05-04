import 'dart:math';

import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WorkoutButton extends StatelessWidget {
  final Function action;
  final String text;
  final IconData icon;

  const WorkoutButton({Key key, this.action, this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipOval(
            child: Material(
              color: Theme.of(Get.context).accentColor, // button color
              child: InkWell(
                splashColor: Colors.transparent, // inkwell color
                child: Container(
                    width: 75,
                    height: 75,
                    child: Center(
                      child: FaIcon(
                        icon,
                        size: 50,
                        color: AppTheme.appBarColor(),
                      ),
                    )),
                onTap: () {
                  action();
                },
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(text, style: TextStyle(color: AppTheme.dynamicColor(), fontWeight: FontWeight.bold, fontSize: 20 ),
          )
        ],
      ),
    );

    return OutlinedButton.icon(
      label: Text('', style: AppTheme.textWhiteBold24()),
      icon: FaIcon(
        icon,
        color: Theme.of(Get.context).canvasColor,
      ),
      onPressed: () {
        action();
      },
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              Theme.of(Get.context).accentColor),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(Get.context).accentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.red)))),
    );
  }
}
