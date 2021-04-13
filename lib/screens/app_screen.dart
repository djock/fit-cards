import 'package:fitcards/screens/home_screen.dart';
import 'package:fitcards/screens/settings_screen.dart';
import 'package:fitcards/screens/workouts_log_screen.dart';
import 'package:fitcards/widgets/safe_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 1;
  List<Widget> _screens = [];

  @override
  void initState() {
    _screens = [
      WorkoutsLogScreen(),
      HomeScreen(),
      SettingsScreen(
        callback: () {
          debugPrint('test');
          setState(() {});
        },
      ),
    ];

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      topSafe: true,
      body: Scaffold(
          body: _screens.elementAt(_selectedIndex),
          bottomNavigationBar: _navigationDrawer,
          floatingActionButton: FloatingActionButton(
              backgroundColor: _selectedIndex == 1
                  ? Theme.of(Get.context).accentColor
                  : Colors.grey,
              child: FaIcon(
                FontAwesomeIcons.running,
                color: Theme.of(Get.context).canvasColor,
              ),
              onPressed: () {
                _onItemTapped(1);
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked),
    );
  }

  Widget get _navigationDrawer {
    return Container(
      child: BottomAppBar(
          color: Theme.of(Get.context).canvasColor,
          elevation: 15,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chartBar,
                    color: _selectedIndex == 0
                        ? Theme.of(Get.context).accentColor
                        : Colors.grey,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.cog,
                      color: _selectedIndex == 2
                          ? Theme.of(Get.context).accentColor
                          : Colors.grey),
                  onPressed: () {
                    _onItemTapped(2);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
