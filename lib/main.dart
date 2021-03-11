import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gur/Utils/SizeConfig.dart';
import 'package:gur/messageScreen.dart';
import 'package:gur/screens/authScreens/login.dart';
import 'package:gur/screens/authScreens/signUpOrg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gur/screens/mainScreens/aboutNgo.dart';
import 'package:gur/screens/mainScreens/home.dart';
import 'package:gur/screens/mainScreens/profile.dart';
import 'Utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn;
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = auth.currentUser;

  if (user == null)
    isLoggedIn = false;
  else
    isLoggedIn = true;

  pref.setBool('isLoggedIn', isLoggedIn);

  runApp(MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSC Challenge',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isLoggedIn == true ? Home() : Login(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

int _selectedIndex = 0;

List<Widget> _widgetOptions = <Widget>[
  HomePage(),
  AboutNgo(),
  MessageScreen(),
  Profile(),
];

class _HomeState extends State<Home> {
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
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
