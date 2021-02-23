import 'package:flutter/material.dart';

class SafeScreen extends StatelessWidget {
  final AppBar appBar;
  final Widget body;

  const SafeScreen({Key key, this.appBar, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            top: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: appBar != null ? appBar : null,
              body: body,
            ),
        ));
  }
}
