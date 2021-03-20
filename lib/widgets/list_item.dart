import 'package:fitcards/handlers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItem extends StatelessWidget {
  final String leftValue;
  final String centerValue;
  final String rightValue;
  final GestureTapCallback onTap;

  const ListItem({Key key, this.leftValue, this.centerValue, this.rightValue, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        direction: Axis.horizontal,
        actionExtentRatio: 0.25,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: Text(
                        leftValue.toString(),
                        style: AppTheme.mediumTextDarkStyle(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                centerValue,
                                style: AppTheme.mediumTextDarkStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      rightValue,
                      style: AppTheme.mediumTextDarkStyle(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _delete(),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => _share(),
          ),
        ],
      ),
    );

    return InkWell(
      onTap:  onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Text(
                      leftValue.toString(),
                      style: AppTheme.mediumTextDarkStyle(),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              centerValue,
                              style: AppTheme.mediumTextDarkStyle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    rightValue,
                    style: AppTheme.mediumTextDarkStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _share() {
    debugPrint('share');
  }

  void _delete() {
    debugPrint('delete');
  }
}
