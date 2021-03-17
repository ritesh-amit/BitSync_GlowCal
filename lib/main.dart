import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gur/screens/authScreens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/mainMenu.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn;
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = auth.currentUser;
  SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent);

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
      home: isLoggedIn == true ? MainMenu() : Login(),
    );
  }
}
