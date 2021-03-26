import 'package:gur/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:gur/screens/mainScreens/ngoHome.dart';
import 'package:gur/screens/mainScreens/ngoProfile.dart';
import 'package:gur/screens/mainScreens/notifications.dart';
import 'package:gur/screens/mainScreens/profile.dart';
import 'package:gur/screens/mainScreens/profileOrg.dart';
import 'package:gur/screens/mainScreens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gur/screens/mainScreens/home.dart';
import 'Utils/constants.dart';
import 'screens/mainScreens/aboutNgo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  SharedPreferences preferences;
  Widget profileSel;
  String type = "";

  List<Widget> _widgetOptionsInd = <Widget>[
    HomePage(),
    Notifications(),
    AboutNgo(),
    Profile(),
  ];

  List<Widget> _widgetOptionsOrg = <Widget>[
    HomePage(),
    Notifications(),
    Settings(),
    ProfileOrg()
  ];

  List<Widget> _widgetOptionsNGO = <Widget>[
    NgoHome(),
    Notifications(),
    AboutNgo(),
    NgoProfile(),
  ];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  loadPreferences() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      type = preferences.getString('currentUserType');
    });
  }

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
              icon: Container(
                  child: SvgPicture.asset(
                _selectedIndex == 0 ? 'images/Home1.svg' : 'images/Home2.svg',
                allowDrawingOutsideViewBox: true,
              )),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset(
                  _selectedIndex == 1 ? 'images/Not.svg' : 'images/not2.svg',
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset(
                  _selectedIndex == 2 ? 'images/Set.svg' : 'images/set2.svg',
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset(
                  _selectedIndex == 3 ? 'images/prof.svg' : 'images/prof2.svg',
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
        body: type == 'ngo'
            ? _widgetOptionsNGO.elementAt(_selectedIndex)
            : type == 'ind'
                ? _widgetOptionsInd.elementAt(_selectedIndex)
                : _widgetOptionsOrg.elementAt(_selectedIndex),
      ),
    );
  }
}
