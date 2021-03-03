import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gur/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainMenu.dart';

var preferences = SharedPreferences.getInstance();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLoggedIn = pref.getBool('isLoggedIn');
  await Firebase.initializeApp();
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
