import 'dart:math';

import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomGradientButton extends StatelessWidget {
  final Function action;
  final String text;
  final IconData icon;
  final double height;

  const CustomGradientButton({Key key, this.action, this.text, this.icon, this.height}) : super(key: key);

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
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Theme.of(Get.context).accentColor, Theme.of(Get.context).accentColor])),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft * 1.1,
              child: Transform.rotate(
                angle:  pi / 12,
                child: IconButton(
                  icon: FaIcon(icon),
                  iconSize: 65,
                  padding: EdgeInsets.zero,
                  color: AppColors.canvasColorLight.withOpacity(0.2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        text,
                        style: AppTheme.textWhiteBold24()
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
