import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/home_screen.dart';
import 'package:fitcards/screens/settings_screen.dart';
import 'package:fitcards/screens/workout_screens/workout_screen.dart';
import 'package:fitcards/screens/workout_screens/workout_tabata_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/custom_gradient_button.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  Future<bool> _onBackPressed() {
    return showDialog(
            context: context,
            builder: (context) => GeneralModal(
                  subTitle: AppLocalizations.closeAppSubtitle,
                  okAction: () => SystemNavigator.pop(),
                  cancelAction: () => Get.back(),
                  okActionText: AppLocalizations.close,
                  cancelActionText: AppLocalizations.cancel,
                )) ??
        false;
  }

  int _selectedIndex = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    _screens = [
//      StatsScreen(),
      HomeScreen(),
      SettingsScreen(
        callback: () {
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeScreen(
        topSafe: true,
        body: Scaffold(
            body: _screens.elementAt(_selectedIndex),
            bottomNavigationBar: _navigationDrawer,
            floatingActionButton: FloatingActionButton(
              elevation: 0,
                backgroundColor: AppColors.inactiveButtonGrey,
                child: FaIcon(
                  FontAwesomeIcons.running,
                  color: Theme.of(Get.context).canvasColor,
                ),
                onPressed: () {
                  _openBottomSheet();
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked),
      ),
    );
  }

  Widget get _navigationDrawer {
    return Container(
      child: BottomAppBar(
          color: AppTheme.appBarColor(),
          elevation: 10,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 42),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chartBar,
                    color: _selectedIndex == 0
                        ? Theme.of(Get.context).accentColor
                        : AppColors.inactiveButtonGrey,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42),
                child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.cog,
                      color: _selectedIndex == 1
                          ? Theme.of(Get.context).accentColor
                          : AppColors.inactiveButtonGrey),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),
              ),
            ],
          )),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildButtons();
      },
    );
  }

  Widget _buildButtons() {
    return Container(
      color: AppTheme.widgetBackground(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomGradientButton(
              text: AppLocalizations.hiit,
              icon: FontAwesomeIcons.random,
              action: () {
                AppStateHandler.shuffleJson();
                Get.back();
                Get.to(() => WorkoutScreen()).then((value) {
                  setState(() {});
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            CustomGradientButton(
              text: AppLocalizations.tabata,
              icon: FontAwesomeIcons.clock,
              action: () {
                AppStateHandler.shuffleJson();
                Get.back();
                Get.to(() => WorkoutTabataScreen()).then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
