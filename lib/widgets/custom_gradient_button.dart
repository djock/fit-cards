import 'dart:math';

import 'package:fitcards/handlers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomGradientButton extends StatelessWidget {
  final Function action;
  final String text;
  final IconData icon;
  final double height;

  const CustomGradientButton(
      {Key key, this.action, this.text, this.icon, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height != null ? height : 65,
        margin: EdgeInsets.only(left: 10, right: 10, top: 13),
        padding: EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(Get.context).accentColor,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(text, style: AppTheme.textWhiteBold24()),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft * 1.12,
              child: Transform.rotate(
                angle: pi / 12,
                child: IconButton(
                  icon: FaIcon(icon, color: Theme.of(Get.context).canvasColor,),
                  iconSize: 65,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
