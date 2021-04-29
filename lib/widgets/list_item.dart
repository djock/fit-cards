import 'package:fitcards/handlers/app_theme.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String leftValue;
  final String centerValue;
  final String rightValue;
  final Color backgroundColor;

  const ListItem(
      {Key key,
      this.leftValue,
      this.centerValue,
      this.rightValue,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.grey(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              leftValue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        backgroundColor: backgroundColor != null
                            ? backgroundColor
                            : AppTheme.grey(),
                        child: Text(
                          leftValue.toString(),
                          style: backgroundColor != null
                              ? AppTheme.customDarkText(FontWeight.bold, 15)
                              : AppTheme.textAccentBold15(),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              centerValue,
                              style: AppTheme.textAccentBold15(),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              rightValue.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        rightValue,
                        style: AppTheme.textAccentBold15(),
                      ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
