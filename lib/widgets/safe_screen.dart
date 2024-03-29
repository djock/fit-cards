import 'package:flutter/material.dart';

class SafeScreen extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool topSafe;

  const SafeScreen(
      {Key? key,
      required this.appBar,
      required this.body,
      required this.topSafe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: Scaffold(
          body: SafeArea(
            top: topSafe != null ? topSafe : false,
            bottom: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: appBar != null ? appBar : null,
              body: body,
            ),
          ),
        ));
  }
}

class SafeScreenWithNavigation extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool topSafe;
  final BottomNavigationBar navigationBar;

  const SafeScreenWithNavigation(
      {Key? key,
      required this.appBar,
      required this.body,
      required this.topSafe,
      required this.navigationBar})
      : super(key: key);

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
              bottomNavigationBar: navigationBar,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.add),
                  onPressed: () {}),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked),
        ));
  }
}
