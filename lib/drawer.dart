import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gur/screens/authScreens/login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class DrawerCode extends StatefulWidget {
  final String userName;
  final String designation;
  final bool hide;
  final String mobileNumber;
  DrawerCode({
    @required this.hide,
    this.userName,
    this.designation,
    this.mobileNumber,
  });
  _DrawerCodeState createState() => _DrawerCodeState();
}

class _DrawerCodeState extends State<DrawerCode> {
  SharedPreferences preferences;
  bool isEmail = false;
  bool isPass = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isName = false;
  bool isPhone = false;
  bool isAddress = false;
  bool isComp = false;
  bool isSuggest = false;
  bool isMission = false;
  bool isAbout = false;
  bool isLogOut = false;
  bool isShare = false;
  bool isVersion = false;

  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";

  loadData() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      userName = preferences.getString("currentUserName");
      email = preferences.getString("currentUserEmail");

      if (preferences.containsKey("currentUserPhone")) {
        userPhone = preferences.getString("currentUserPhone");
      } else {
        userPhone = "Not Provided";
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 27 / 414,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 107 / 896,
            ),
            Text(
              userName, //this.userName
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.screenWidth * 30 / 414,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 21 / 896,
            ),
            Text(
              "Designation", // this.designation
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.screenWidth * 16 / 414,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 11 / 896,
            ),
            InkWell(
              child: Row(
                children: [
                  Icon(Icons.call, color: textColor),
                  SizedBox(
                    width: SizeConfig.screenWidth * 8 / 414,
                  ),
                  Text(
                    userPhone, // this.phoneNumber
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.screenWidth * 14 / 414,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 18 / 896,
            ),
            Container(
              margin: EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
              color: rc,
              height: SizeConfig.screenHeight * 1 / 896,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 50 / 896,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isComp = !isComp;
                  sendComplaintMail();
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isComp ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Complaints",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 10 / 896,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSuggest = !isSuggest;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isSuggest ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.emoji_emotions, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Suggestions",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 10 / 896,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isMission = !isMission;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isMission ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hearing, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Mission",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 10 / 896,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isAbout = !isAbout;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isAbout ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "About the App",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 10 / 896,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isLogOut = !isLogOut;
                  logOut();
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isLogOut ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(MdiIcons.logout, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 40 / 640,
            ),
            Container(
              margin: EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
              color: rc,
              height: SizeConfig.screenHeight * 1 / 896,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 23 / 640,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isShare = !isShare;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isShare ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.share, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Share the App",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isVersion = !isVersion;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: SizeConfig.screenWidth * 27 / 414),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 12 / 414,
                  vertical: SizeConfig.screenHeight * 12 / 896,
                ),
                decoration: BoxDecoration(
                  color: isVersion ? Color(0xfffff2e1) : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 10 / 414),
                ),
                child: Row(
                  children: [
                    Icon(Icons.graphic_eq, color: rc),
                    SizedBox(
                      width: SizeConfig.screenWidth * 13 / 360,
                    ),
                    Text(
                      "Version 1.0",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      await firebaseAuth.signOut().then((value) {
        preferences.setBool('isLoggedIn', false);
        preferences.remove('currentUserName');
        preferences.remove('currentUserPhone');
        preferences.remove('currentUserEmail');
        print("Signed Out");
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return Login();
          }),
          (route) => false,
        );
      }).catchError((e) {
        print(e);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void sendComplaintMail() async {
    Email email = Email(
      recipients: ['sisodiasuraj2000@gmail.com'],
      subject: 'Regarding DSC App',
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
