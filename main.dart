import 'package:flutter/material.dart';
import 'package:gur/Utils/constants.dart';
import 'package:gur/profile.dart';

void main() {
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
      home: Profile(),
    );
  }
}
