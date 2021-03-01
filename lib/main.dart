import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gur/Utils/constants.dart';
import 'package:gur/forgotPassword.dart';
import 'package:gur/login.dart';
import 'package:gur/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dsc Solution Challenge',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: gc,
        visualDensity: VisualDensity.standard,
      ),
      home: Login(),
    );
  }
}
