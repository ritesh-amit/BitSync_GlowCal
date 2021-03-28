import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/drawerPages/drawer.dart';
import 'package:gur/screens/mainScreens/home.dart';
import 'package:gur/searchScreens/searchNgo.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List mainImageList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadMainImageList() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'ngo')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;
      mainImageList.clear();
      setState(() {
        for (var i in documentSnapshot) {
          mainImageList
              .add({'imageURL': i.data()['image1'], 'uid': i.data()['uid']});
        }
      });
    });

    //return mainImageList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          HomePage(),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
              child: ListView(
                children: [
                  sh(30),
                  Row(
                    children: [
                      SizedBox(width: b * 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: h * 40,
                          width: b * 40,
                          child: SvgPicture.asset(
                            'images/Arrow1.svg',
                            color: Colors.white,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  sh(40),
                  SearchScreen(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }
}
