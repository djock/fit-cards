import 'package:fitcards/handlers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGradientButton extends StatelessWidget {
  final Function action;
  final String text;

  const CustomGradientButton({Key key, this.action, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        margin: EdgeInsets.only(left: 10, right: 10, top: 13),
        padding: EdgeInsets.all(20.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Theme.of(Get.context).accentColor, Theme.of(Get.context).accentColor])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                text,
                style: AppTheme.textWhiteBold24()
            ),
          ],
        ),
      ),
    );
  }
}
