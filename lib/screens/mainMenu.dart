import 'package:flutter/material.dart';
import 'package:gur/screens/mainScreens/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:gur/Utils/constants.dart';
import '../Utils/SizeConfig.dart';
import 'mainScreens/aboutNgo.dart';
import 'mainScreens/home.dart';

BuildContext testContext;

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      AboutNgo(),
      AboutNgo(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    SizeConfig().init(context);
    return [
      PersistentBottomNavBarItem(
        icon: Container(
          alignment: Alignment.centerLeft,
          width: SizeConfig.screenWidth * 0.15,
          child: Column(children: [
            Icon(Icons.home),
            Text(
              "Home",
              style: TextStyle(
                fontSize: SizeConfig.screenWidth * 11 / 360,
              ),
            ),
          ]),
        ),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          alignment: Alignment.center,
          width: SizeConfig.screenWidth * 0.25,
          child: Column(children: [
            Icon(Icons.notifications),
            Text(
              "Notifcations",
              style: TextStyle(
                fontSize: SizeConfig.screenWidth * 11 / 360,
              ),
            ),
          ]),
        ),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          alignment: Alignment.center,
          width: SizeConfig.screenWidth * 0.3,
          child: Column(children: [
            Icon(Icons.settings),
            Text(
              "Settings",
              style: TextStyle(
                fontSize: SizeConfig.screenWidth * 11 / 360,
              ),
            ),
          ]),
        ),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          alignment: Alignment.centerRight,
          width: SizeConfig.screenWidth * 0.15,
          child: Column(children: [
            Icon(Icons.person),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: SizeConfig.screenWidth * 11 / 360,
              ),
            ),
          ]),
        ),
        activeColor: mc,
        inactiveColor: textColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.once,
        bottomScreenMargin: 0.0,
        onWillPop: () async {
          return false;
        },
        selectedTabScreenContext: (context) {
          testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 5),
        ),
        navBarStyle: NavBarStyle.simple,
      ),
    );
  }
}
