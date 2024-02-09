import 'package:fitcards/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReorderableListItem extends StatelessWidget {
  final String leftValue;
  final String centerValue;
  final String rightValue;
  final GestureTapCallback onTap;
  final Function deleteAction;
  final Function shareAction;
  final Color backgroundColor;

  const ReorderableListItem(
      {Key? key,
      required this.leftValue,
      required this.centerValue,
      required this.rightValue,
      required this.onTap,
      required this.deleteAction,
      required this.shareAction,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        direction: Axis.horizontal,
        child: ListItem(
          leftValue: leftValue,
          centerValue: centerValue,
          rightValue: rightValue,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  void _share() {
    shareAction();
  }

  void _delete() {
    deleteAction();
  }
}
