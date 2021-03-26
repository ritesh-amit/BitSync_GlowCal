import 'package:gur/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:gur/screens/mainScreens/notifications.dart';
import 'package:gur/screens/mainScreens/profile.dart';

import 'package:gur/screens/mainScreens/home.dart';
import 'package:gur/screens/mainScreens/settings.dart';
import 'Utils/constants.dart';
import 'screens/mainScreens/aboutNgo.dart';

class HomeInd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeIndState();
  }
}

class _HomeIndState extends State<HomeInd> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptionsInd = <Widget>[
    HomePage(),
    Notifications(),
    Settings(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: mc,
            elevation: 10,
            selectedFontSize: SizeConfig.screenWidth * 14 / 414,
            unselectedFontSize: SizeConfig.screenWidth * 12 / 414,
            unselectedItemColor: Color(0xff130f26),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          body: _widgetOptionsInd.elementAt(_selectedIndex)),
    );
  }
}
