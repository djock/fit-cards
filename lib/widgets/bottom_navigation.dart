import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();

}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: const Text('Here be navigation!',
          style: TextStyle(fontSize: 20)),
      color: Colors.blue,
      textColor: Theme.of(Get.context).textTheme.bodyText1.color,
    );
  }
}
