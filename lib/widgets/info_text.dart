import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:flutter/cupertino.dart';

class InfoText extends StatelessWidget {
  final String info;
  final String value;
  final IconData icon;

  const InfoText({Key key, this.info, this.value, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value.isNotEmpty && value != '1' && value != '0s') {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            color: AppColors.textColor,
            size: 16,
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              info + ' ' + value,
              style: AppTheme.smallTextLightStyle(),
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
