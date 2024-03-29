import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class IconListItem extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData rightIcon;
  final Function function;

  const IconListItem(
      {Key? key,
      required this.text,
      required this.leftIcon,
      required this.rightIcon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(Get.context!).canvasColor, // AppTheme.widgetBackground(),
      child: ListTile(
        onTap: () {
          function();
                },
        contentPadding: EdgeInsets.only(left: 24, right: 24),
        title: Text(
          text,
          style: AppTheme.textAccentBold15(), // AppTheme.textAccentNormal15(),
        ),
        leading: leftIcon != null
            ? _buildIcon(leftIcon, Theme.of(Get.context!).primaryColor)
            : SizedBox(),
        trailing: rightIcon != null
            ? _buildIcon(rightIcon, AppColors.inactiveButtonGrey)
            : SizedBox(),
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: FaIcon(
        icon,
        color: color,
      ),
    );
  }
}
