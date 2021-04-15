import 'package:fitcards/handlers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItem extends StatelessWidget {
  final String leftValue;
  final String centerValue;
  final String rightValue;
  final GestureTapCallback onTap;
  final Function deleteAction;
  final Function shareAction;
  final Color backgroundColor;

  const ListItem({Key key, this.leftValue, this.centerValue, this.rightValue, this.onTap, this.deleteAction, this.shareAction, this.backgroundColor}) : super(key: key);

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
                  leftValue.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundColor: backgroundColor != null ? backgroundColor : Colors.grey.withOpacity(0.1),
                      child: Text(
                        leftValue.toString(),
                        style: backgroundColor != null ? AppTheme.customDarkText(FontWeight.bold, 15  ) : AppTheme.textAccentBold15(),
                      ),
                    ),
                  ) : SizedBox(width: 0,),
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
                  rightValue.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      rightValue,
                      style: AppTheme.textAccentBold15(),
                    ),
                  ) : SizedBox(width: 0,),
                ],
              ),
            ],
          ),
        ),
        secondaryActions: _buildActions(),
      ),
    );
  }
  
  List<Widget> _buildActions() {
    List<Widget> result = [];

    if(deleteAction != null || shareAction != null) {
      if(deleteAction != null) {
        result.add(IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _delete(),
        ));
      }
      if(shareAction != null) {
        result.add(IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _share(),
        ));
      }
    }
    return result;
  }

  void _share() {
    shareAction();
  }

  void _delete() {
    deleteAction();
  }
}
