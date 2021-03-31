import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gur/homePages/homeMainInd.dart';
import 'package:gur/homePages/homeMainNGO.dart';
import 'package:gur/homePages/homeMainOrg.dart';
import 'package:gur/newAuthScreens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn = false;
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = auth.currentUser;
  /*SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );*/

  if (user == null)
    isLoggedIn = false;
  else
    isLoggedIn = true;
  String homeType;
  if (pref.containsKey('currentUserType'))
    homeType = pref.getString('currentUserType');

  runApp(MyApp(isLoggedIn, homeType));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String homeType;
  MyApp(this.isLoggedIn, this.homeType);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlowCal',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: !isLoggedIn
          ? Login()
          : homeType == 'ind'
              ? HomeInd()
              : homeType == 'org'
                  ? HomeOrg()
                  : HomeNgo(),
    );
  }
}
