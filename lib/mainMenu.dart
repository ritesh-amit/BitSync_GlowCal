import 'package:flutter/material.dart';
import 'package:gur/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:gur/Utils/constants.dart';
import 'Utils/SizeConfig.dart';
import 'aboutNgo.dart';
import 'home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      AboutNgo(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            MdiIcons.fileDocument,
            color: Colors.white,
            size: SizeConfig.screenWidth * 24 / 414,
          ),
          Text(
            "Sponsors",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.screenWidth * 10 / 414,
            ),
          ),
        ]),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notifications"),
        activeColor: mc,
        inactiveColor: textColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
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
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
