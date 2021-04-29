import 'package:fitcards/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableListItem extends StatelessWidget {
  final String leftValue;
  final String centerValue;
  final String rightValue;
  final GestureTapCallback onTap;
  final Function deleteAction;
  final Function shareAction;
  final Color backgroundColor;

  const SlidableListItem(
      {Key key,
      this.leftValue,
      this.centerValue,
      this.rightValue,
      this.onTap,
      this.deleteAction,
      this.shareAction,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        direction: Axis.horizontal,
        actionExtentRatio: 0.25,
        child: ListItem(
          leftValue: leftValue,
          centerValue: centerValue,
          rightValue: rightValue,
          backgroundColor: backgroundColor,
        ),
        secondaryActions: _buildActions(),
      ),
    );
  }

  List<Widget> _buildActions() {
    List<Widget> result = [];

    if (deleteAction != null || shareAction != null) {
      if (deleteAction != null) {
        result.add(IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _delete(),
        ));
      }
      if (shareAction != null) {
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
