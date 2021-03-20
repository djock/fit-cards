import 'package:flutter/material.dart';

class SafeScreen extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool topSafe;

  const SafeScreen({Key key, this.appBar, this.body, this.topSafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            top: topSafe != null ? topSafe : false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: appBar != null ? appBar : null,
              body: body,
            ),
        ));
  }
}
