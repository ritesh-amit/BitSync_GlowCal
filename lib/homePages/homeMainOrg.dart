import 'package:gur/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:gur/screens/mainScreens/notifications.dart';
import 'package:gur/screens/mainScreens/profileOrg.dart';
import 'package:gur/screens/mainScreens/settings.dart';
import 'package:gur/screens/mainScreens/home.dart';
import '../Utils/constants.dart';
import 'dart:ui' show lerpDouble;
import 'package:flutter_svg/flutter_svg.dart';

class HomeOrg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeOrgState();
  }
}

class _HomeOrgState extends State<HomeOrg> {
  int _selectedIndex = 0;
  List items = [1, 2, 3, 4];
  Duration duration = Duration(milliseconds: 170);

  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  List<Widget> _widgetOptionsOrg = <Widget>[
    HomePage(),
    Notifications(),
    Settings(),
    ProfileOrg()
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: h * 71,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            AnimatedAlign(
              alignment: Alignment(_getIndicatorPosition(_selectedIndex), 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                color: mc ?? Colors.transparent,
                width: b * 412 / items.length,
                height: h * 2,
              ),
            ),
            BottomNavigationBar(
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
                  icon: Container(
                      child: SvgPicture.asset(
                    _selectedIndex == 0
                        ? 'images/Home1.svg'
                        : 'images/Home2.svg',
                    allowDrawingOutsideViewBox: true,
                  )),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: SvgPicture.asset(
                      _selectedIndex == 1
                          ? 'images/Not.svg'
                          : 'images/not2.svg',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: SvgPicture.asset(
                      _selectedIndex == 2
                          ? 'images/Set.svg'
                          : 'images/Set1.svg',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: SvgPicture.asset(
                      _selectedIndex == 3
                          ? 'images/prof.svg'
                          : 'images/prof2.svg',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ]),
        ),
        body: _widgetOptionsOrg.elementAt(_selectedIndex),
      ),
    );
  }
}
