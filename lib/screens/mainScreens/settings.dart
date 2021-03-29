import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gur/newAuthScreens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/drawerPages/drawer.dart';
import 'package:gur/screens/chatSection/messageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pwdController = TextEditingController();
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool suraj = false;

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
            child: SingleChildScrollView(
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
                                  "   On",
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
                                  "Off   ",
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
                                  "Hin  ",
                                  style: txtS(textColor, 12, FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        sh(25),
                      ],
                    ),
                    sh(25),
                    Row(
                      children: [
                        MaterialButton(
                          height: h * 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(b * 6),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            dialogBoxDelete(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Text(
                              "Delete Account",
                              style: txtS(Colors.white, 16, FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                    sh(220),
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
                              'images/Heart2.svg',
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

  void dialogBoxDelete(BuildContext context) {
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: b * 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(b * 10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: h * 20),
                padding: EdgeInsets.symmetric(horizontal: b * 22),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want to delete the GlowCal Account??',
                      textAlign: TextAlign.center,
                      style: txtS(textColor, 16, FontWeight.w500),
                    ),
                    SizedBox(height: h * 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: b * 200,
                          child: TextFormField(
                            controller: pwdController,
                            obscuringCharacter: '*',
                            obscureText: !suraj,
                            style: txtS(textColor, 16, FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: "Enter Password to Continue",
                              hintStyle: txtS(textColor, 14, FontWeight.w400),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: SizeConfig.screenWidth / 414 * 16,
                                minHeight: SizeConfig.screenHeight / 896 * 12,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.screenWidth /
                                        414 *
                                        15 /
                                        414),
                                child: InkWell(
                                  onTap: () {
                                    print(suraj);
                                    setState(() {
                                      suraj = !suraj;
                                    });
                                  },
                                  child: Icon(
                                    suraj
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                    size: SizeConfig.screenWidth / 414 * 16,
                                  ),
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight / 896 * 9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sh(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          elevation: 5,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(b * 36),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: b * 97,
                            height: h * 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(b * 36),
                              border: Border.all(
                                color: Color(0xff28797c),
                                width: b * 2,
                              ),
                            ),
                            child: Text(
                              'NO',
                              style:
                                  txtS(Color(0xff28797c), 16, FontWeight.w600),
                            ),
                          ),
                        ),
                        MaterialButton(
                          elevation: 5,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                            deleteUser();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(b * 36),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: b * 97,
                            height: h * 40,
                            decoration: BoxDecoration(
                              color: Color(0xff28797c),
                              borderRadius: BorderRadius.circular(b * 36),
                            ),
                            child: Text(
                              'YES',
                              style: txtS(Colors.white, 16, FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  deleteUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
          content:
              Text('Account Deleted Successfully.We are going to miss you!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Login();
        }), (route) => false);
      });
    }).catchError((error) {
      if (error.code == 'requires-recent-login') {
        FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(
                EmailAuthProvider.credential(email: email, password: pwd))
            .then((credential) {
          FirebaseAuth.instance.currentUser.delete().catchError((er) {
            print(er.message);
          });
          preferences.clear();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Account Deleted Successfully. We gonna miss you !"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return Login();
          }), (route) => false);
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.code),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
        });
      } else {
        print(error.code);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }
}
