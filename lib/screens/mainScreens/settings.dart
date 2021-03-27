import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gur/newAuthScreens/login.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/drawer.dart';
import 'package:gur/screens/chatSection/messageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pwdController = TextEditingController();
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCode(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Container(
            height: h * 60,
            padding: EdgeInsets.symmetric(horizontal: b * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: b * 4,
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        height: h * 30,
                        width: b * 30,
                        child: SvgPicture.asset(
                          'images/Chart.svg',
                          allowDrawingOutsideViewBox: true,
                          width: h * 20,
                          height: b * 20,
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                Text(
                  'Settings',
                  style: txtS(mc, 20, FontWeight.w600),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MessageScreen(
                          uid: FirebaseAuth.instance.currentUser.uid);
                    }));
                  },
                  child: Container(
                    height: h * 30,
                    width: b * 30,
                    child: SvgPicture.asset(
                      'images/SendColor.svg',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          sh(18),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Theme",
                              style: txtS(textColor, 20, FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Light",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                              SizedBox(width: b * 4),
                              FlutterSwitch(
                                padding: 0.6,
                                width: b * 45,
                                height: h * 25,
                                toggleSize: b * 20,
                                value: status2,
                                borderRadius: b * 24,
                                toggleColor: Colors.black,
                                switchBorder: Border.all(
                                  color: textColor,
                                  width: b * 1,
                                ),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white,
                                onToggle: (val) {
                                  setState(() {
                                    status2 = val;
                                  });
                                },
                              ),
                              SizedBox(width: b * 4),
                              Text(
                                "Dark",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sh(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Notifications",
                              style: txtS(textColor, 20, FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "On",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                              SizedBox(width: b * 4),
                              FlutterSwitch(
                                padding: 0.6,
                                width: b * 45,
                                height: h * 25,
                                toggleSize: b * 20,
                                value: status1,
                                borderRadius: b * 24,
                                toggleColor: mc,
                                switchBorder: Border.all(
                                  color: mc,
                                  width: b * 1,
                                ),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white,
                                onToggle: (val) {
                                  setState(() {
                                    status1 = val;
                                  });
                                },
                              ),
                              SizedBox(width: b * 4),
                              Text(
                                "Off",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sh(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Language",
                              style: txtS(textColor, 20, FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Eng",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                              SizedBox(width: b * 4),
                              FlutterSwitch(
                                padding: 0.6,
                                width: b * 45,
                                height: h * 25,
                                toggleSize: b * 20,
                                value: status3,
                                borderRadius: b * 24,
                                toggleColor: Color(0xff28797c),
                                switchBorder: Border.all(
                                  color: Color(0xff28797c),
                                  width: b * 1,
                                ),
                                activeColor: Colors.white,
                                inactiveColor: Colors.white,
                                onToggle: (val) {
                                  setState(() {
                                    status3 = val;
                                  });
                                },
                              ),
                              SizedBox(width: b * 4),
                              Text(
                                "Hin",
                                style: txtS(textColor, 12, FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sh(25),
                      MaterialButton(
                        onPressed: () {
                          deleteUser();
                        },
                        child: Text("Delete"),
                        color: Colors.red,
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/icon.png',
                              height: h * 127, width: b * 127),
                        ],
                      ),
                      sh(15),
                      Text(
                        'GlowCal',
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                      Text(
                        'V 1.1.0',
                        style: txtS(textColor, 14, FontWeight.w600),
                      ),
                      sh(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Created with ',
                            style: txtS(textColor, 12, FontWeight.w400),
                          ),
                          SvgPicture.asset(
                            'images/Heart.svg',
                            allowDrawingOutsideViewBox: true,
                            width: h * 23,
                            height: b * 23,
                          ),
                          Text(
                            ' by Team ',
                            style: txtS(textColor, 12, FontWeight.w400),
                          ),
                          Text(
                            ' BitSync',
                            style: txtS(textColor, 13, FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  sh(10),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: h * SizeConfig.screenHeight / 896);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth / 412 * siz,
    );
  }

  deleteUser() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    String email = FirebaseAuth.instance.currentUser.email;
    String pwd = pwdController.text;

    FirebaseAuth.instance.currentUser.delete().then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .delete()
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Account Deleted Successfully. We gonna miss u !'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Login();
        }), (route) => false);
      });
    }).catchError((error) {
      if (error.message == 'requires-recent-login') {
        FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(
                EmailAuthProvider.credential(email: email, password: pwd))
            .then((credential) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Account Deleted Successfully. We gonna miss u !"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return Login();
          }), (route) => false);
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
        });
      } else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
    });
  }
}
