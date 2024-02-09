import 'package:fitcards/handlers/app_state_handler.dart';
import 'package:fitcards/handlers/app_theme.dart';
import 'package:fitcards/screens/home_screen.dart';
import 'package:fitcards/screens/settings_screen.dart';
import 'package:fitcards/screens/workout_screens/workout_hiit_screen.dart';
import 'package:fitcards/screens/workout_screens/workout_tabata_screen.dart';
import 'package:fitcards/utilities/app_colors.dart';
import 'package:fitcards/utilities/app_localizations.dart';
import 'package:fitcards/widgets/general_modal.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:fitcards/widgets/workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  Future<bool> _onBackPressed() async {
    await showDialog(
        context: context,
        builder: (context) => GeneralModal(
              subTitle: AppLocalizations.closeAppSubtitle,
              okAction: () => SystemNavigator.pop(),
              cancelAction: () => Get.back(),
              okActionText: AppLocalizations.close,
              cancelActionText: AppLocalizations.cancel,
              title: '',
            ));

    return true;
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
        topSafe: false,
        body: Scaffold(
            body: _screens.elementAt(_selectedIndex),
            bottomNavigationBar: _navigationDrawer,
            floatingActionButton: FloatingActionButton(
                elevation: 0,
                backgroundColor: AppColors.inactiveButtonGrey,
                child: FaIcon(
                  FontAwesomeIcons.running,
                  color: Theme.of(Get.context!).canvasColor,
                ),
                onPressed: () {
                  _openBottomSheet();
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked),
        appBar: AppBar(),
      ),
    );
  }

  Widget get _navigationDrawer {
    return Container(
      child: BottomAppBar(
          color: AppTheme.appBarColor(),
          elevation: 0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 42),
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chartBar,
                    color: AppColors.inactiveButtonGrey,
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
                      color: AppColors.inactiveButtonGrey),
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
      backgroundColor: AppTheme.widgetBackground().withOpacity(0.8),
      builder: (BuildContext context) {
        return _buildButtons();
      },
    );
  }

  Widget _buildButtons() {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        color: AppTheme.appBarColor().withOpacity(0.3),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24.0, right: 24, bottom: 36, top: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WorkoutButton(
                text: AppLocalizations.hiit,
                icon: FontAwesomeIcons.random,
                action: () {
                  AppStateHandler.shuffleJson();
                  Get.back();
                  Get.to(() => WorkoutHiitScreen())!.then((value) {
                    setState(() {});
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              WorkoutButton(
                text: AppLocalizations.tabata,
                icon: FontAwesomeIcons.clock,
                action: () {
                  AppStateHandler.shuffleJson();
                  Get.back();
                  Get.to(() => WorkoutTabataScreen())!.then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
