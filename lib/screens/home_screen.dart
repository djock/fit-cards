import 'package:fitcards/screens/feed_screen.dart';
import 'package:fitcards/screens/workouts_log_screen.dart';
import 'package:fitcards/widgets/safe_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    FeedScreen(),
    WorkoutsLogScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeScreen(
      appBar: null,
      body: Scaffold(
          body: _screens[_currentIndex],
//          bottomNavigationBar: Container(
//            decoration: BoxDecoration(
//              border: Border(
//                top: BorderSide(
//                  color: AppColors.mandarin,
//                  width: 0.2,
//                ),
//              ),
//            ),
//            child: BottomNavigationBar(
//              backgroundColor: AppColors.mainGrey,
//              type: BottomNavigationBarType.fixed,
//              elevation: 0,
//              onTap: _onTabTapped,
//              currentIndex: _currentIndex,
//              unselectedItemColor: AppColors.mainColor,
//              selectedItemColor: AppColors.mandarin,
//              showUnselectedLabels: false,
//              showSelectedLabels: false,
//              unselectedFontSize: 13,
//              selectedFontSize: 13,
//              items: [
//                BottomNavigationBarItem(
//                  icon: Icon(Icons.home, size: 32,),
//                  label: AppLocalizations.feed,
//                ),
//                BottomNavigationBarItem(
//                  icon: Icon(Icons.calendar_today, size: 30,),
//                  label: AppLocalizations.log,
//                ),
//              ],
//            ),
//          )
      ),
    );
  }
//
//  _onTabTapped(newValue) {
//    setState(() {
//      _currentIndex = newValue;
//    });
//  }
}
