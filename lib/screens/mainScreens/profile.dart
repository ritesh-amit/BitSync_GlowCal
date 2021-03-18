import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  TextEditingController addressController = TextEditingController();
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController newConfirmPwdController = TextEditingController();

  bool isEmail = false;
  bool isPass = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isName = false;
  bool isPhone = false;
  bool isAddress = false;
  String userName = "";
  String userPhone = "";
  String address = "";
  bool suraj = false;
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

      if (preferences.containsKey('currentUserAddress')) {
        address = preferences.getString('currentUserAddress');
        addressController.text = address;
      } else
        address = "Not Provided";
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
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerCode(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
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
                        InkWell(
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
                        ),
                        Spacer(),
                        Text(
                          'Profile',
                          style: txtS(mc, 20, FontWeight.w600),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: h * 30,
                            width: b * 30,
                            child: SvgPicture.asset(
                              'images/SendColor.svg',
                              allowDrawingOutsideViewBox: true,
                              width: h * 20,
                              height: b * 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sh(23),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 375,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ico('images/Group 23.svg'),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              isName ? 'Change Name' : 'Name',
                              style: txtS(
                                  isName ? textColor : rc, 14, FontWeight.w500),
                            ),
                            sh(6),
                            isName
                                ? Container(
                                    width: b * 270,
                                    child: TextField(
                                      style:
                                          txtS(textColor, 15, FontWeight.w500),
                                      decoration: dec('Your Name'),
                                    ),
                                  )
                                : Text(
                                    userName,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                  ),
                            isName ? butt(null) : SizedBox(),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isName = !isName;
                                });
                              },
                              child: ediB(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 375,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ico('images/Call.svg'),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              isPhone ? 'Change Number' : 'Number',
                              style: txtS(isPhone ? textColor : rc, 14,
                                  FontWeight.w500),
                            ),
                            sh(6),
                            isPhone
                                ? Container(
                                    width: b * 270,
                                    child: TextField(
                                      style:
                                          txtS(textColor, 15, FontWeight.w500),
                                      decoration: dec('Phone Number'),
                                    ),
                                  )
                                : Text(
                                    userPhone,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                  ),
                            isPhone ? butt(null) : SizedBox(),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPhone = !isPhone;
                                });
                              },
                              child: ediB(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 375,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ico('images/Message.svg'),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Email',
                              style: txtS(rc, 14, FontWeight.w500),
                            ),
                            sh(6),
                            Text(
                              email,
                              style: txtS(textColor, 16, FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 375,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ico('images/Password.svg'),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              !isPass ? 'Password' : "Update Password",
                              style: txtS(!isPass ? rc : textColor, 14,
                                  FontWeight.w500),
                            ),
                            sh(6),
                            !isPass
                                ? Text(
                                    '**************',
                                    style: txtS(textColor, 16, FontWeight.w500),
                                  )
                                : Container(
                                    width: b * 270,
                                    child: TextFormField(
                                      controller: oldPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible,
                                      style:
                                          txtS(textColor, 16, FontWeight.w500),
                                      decoration: deco('Your Old Password', 1),
                                    ),
                                  ),
                            isPass ? sh(10) : SizedBox(),
                            isPass
                                ? Container(
                                    width: b * 270,
                                    child: TextFormField(
                                      controller: newPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible2,
                                      style:
                                          txtS(textColor, 16, FontWeight.w500),
                                      decoration: deco('New Password', 2),
                                    ),
                                  )
                                : SizedBox(),
                            isPass ? sh(10) : SizedBox(),
                            isPass
                                ? Container(
                                    width: b * 270,
                                    child: TextFormField(
                                      controller: newConfirmPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible3,
                                      style:
                                          txtS(textColor, 16, FontWeight.w500),
                                      decoration:
                                          deco('Confirm New Password', 3),
                                    ),
                                  )
                                : SizedBox(),
                            isPass
                                ? Padding(
                                    padding: EdgeInsets.only(left: b * 180),
                                    child: InkWell(
                                      onTap: () {
                                        if (newPwdController.text ==
                                            newConfirmPwdController.text) {
                                          pwdChangeRequest(
                                              oldPwdController.text,
                                              newPwdController.text);
                                        } else {
                                          Toast.show(
                                              "Password Mismatch", context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: h * 11),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: b * 17,
                                            vertical: h * 7),
                                        width: b * 90,
                                        decoration: BoxDecoration(
                                          color: mc,
                                          borderRadius:
                                              BorderRadius.circular(b * 18),
                                        ),
                                        child: Row(children: [
                                          Text(
                                            'Save',
                                            style: txtS(Colors.white, 12,
                                                FontWeight.w400),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: b * 18,
                                          ),
                                        ]),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isPass = !isPass;
                                });
                              },
                              child: ediB(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 375,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ico('images/Location.svg'),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              !isAddress ? 'Address' : 'Change Adrdress',
                              style: txtS(!isAddress ? rc : textColor, 14,
                                  FontWeight.w500),
                            ),
                            sh(6),
                            !isAddress
                                ? Container(
                                    width: b * 235,
                                    child: Text(
                                      address,
                                      style: txtS(!isAddress ? textColor : rc,
                                          16, FontWeight.w500),
                                    ),
                                  )
                                : Container(
                                    width: b * 270,
                                    child: TextFormField(
                                      controller: addressController,
                                      style:
                                          txtS(textColor, 16, FontWeight.w500),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: b,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: b,
                                          ),
                                        ),
                                        hintText: 'Your Address',
                                        hintStyle: txtS(
                                            textColor, 14, FontWeight.w400),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: h * 9),
                                      ),
                                    ),
                                  ),
                            isAddress
                                ? Padding(
                                    padding: EdgeInsets.only(left: b * 180),
                                    child: InkWell(
                                      onTap: () {
                                        preferences.setString(
                                            'currentUserAddress',
                                            addressController.text.trim());
                                        setState(() {
                                          isAddress = !isAddress;
                                        });
                                        addressChangeRequest(
                                            addressController.text.trim());
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: h * 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: b * 17,
                                            vertical: h * 7),
                                        width: b * 90,
                                        decoration: BoxDecoration(
                                          color: mc,
                                          borderRadius:
                                              BorderRadius.circular(b * 18),
                                        ),
                                        child: Row(children: [
                                          Text(
                                            'Save',
                                            style: txtS(Colors.white, 12,
                                                FontWeight.w500),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: b * 18,
                                          ),
                                        ]),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isAddress = !isAddress;
                                });
                              },
                              child: ediB(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sh(200),
                ],
              ),
            ),
          ),
        ));
  }

  Padding butt(Function fn) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth / 414 * 180,
          top: SizeConfig.screenHeight / 896 * 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth / 414 * 17,
            vertical: SizeConfig.screenHeight / 896 * 7,
          ),
          width: SizeConfig.screenWidth / 414 * 90,
          decoration: BoxDecoration(
            color: mc,
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth / 414 * 18),
          ),
          child: Row(children: [
            Text(
              'Save',
              style: txtS(Colors.white, 12, FontWeight.w400),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: SizeConfig.screenWidth / 414 * 18,
            ),
          ]),
        ),
      ),
    );
  }

  Container ediB() {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Container(
      height: h * 20,
      width: b * 20,
      child: SvgPicture.asset(
        'images/edit.svg',
        allowDrawingOutsideViewBox: true,
        width: h * 20,
        height: b * 20,
      ),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  UnderlineInputBorder under() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: rc,
        width: SizeConfig.screenWidth * 1 / 414,
      ),
    );
  }

  InputDecoration deco(String hi, int isV) {
    return InputDecoration(
      enabledBorder: under(),
      focusedBorder: under(),
      hintText: hi,
      hintStyle: txtS(textColor, 14, FontWeight.w400),
      suffixIconConstraints: BoxConstraints(
        minWidth: SizeConfig.screenWidth / 414 * 16,
        minHeight: SizeConfig.screenHeight / 896 * 12,
      ),
      suffixIcon: Padding(
        padding:
            EdgeInsets.only(right: SizeConfig.screenWidth / 414 * 15 / 414),
        child: InkWell(
          onTap: () {
            setState(() {
              if (isV == 1) {
                isVisible = !isVisible;
                suraj = isVisible;
              } else if (isV == 2) {
                isVisible2 = !isVisible2;
                suraj = isVisible2;
              } else if (isV == 3) {
                isVisible3 = !isVisible3;
                suraj = isVisible3;
              }

              print(isVisible);
              print(isVisible2);
              print(isVisible3);
              print(suraj);
            });
          },
          child: Icon(
            suraj ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
            size: SizeConfig.screenWidth / 414 * 16,
          ),
        ),
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight / 896 * 9),
    );
  }

  Container ico(String qwerty) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Container(
      height: h * 20,
      width: b * 20,
      child: SvgPicture.asset(
        qwerty,
        allowDrawingOutsideViewBox: true,
        width: h * 20,
        height: b * 20,
      ),
    );
  }

  InputDecoration dec(String hin) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: rc,
          width: SizeConfig.screenWidth / 414 * 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: rc,
          width: SizeConfig.screenWidth * 1 / 414,
        ),
      ),
      hintText: hin,
      hintStyle: TextStyle(
        color: textColor,
        fontSize: SizeConfig.screenWidth / 414 * 14,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 9 / 896),
    );
  }

  BoxDecoration bord() {
    return BoxDecoration(
      border: Border.all(
        color: rc,
        width: SizeConfig.screenWidth * 1 / 414,
      ),
      borderRadius: BorderRadius.circular(SizeConfig.screenWidth / 414 * 8),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  pwdChangeRequest(String pwd, String newPwd) {
    FirebaseAuth auth = FirebaseAuth.instance;

    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pwd);

    auth.currentUser.reauthenticateWithCredential(credential).catchError((e) {
      print("Error is: $e");
    }).then((value) {
      auth.currentUser.updatePassword(newPwd).catchError((e) {
        print(e);
      }).timeout(Duration(seconds: 10), onTimeout: () {
        Toast.show("Server Error", context, duration: Toast.LENGTH_LONG);
      }).then((value) {
        Toast.show("Password Changed Succesfully", context,
            duration: Toast.LENGTH_LONG);
        setState(() {
          isPass = !isPass;
        });
      });
    });
  }

  addressChangeRequest(String adr) {
    String userUID = preferences.getString("currentUserUID");

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userUID)
          .update({'address': adr}).then((value) {
        setState(() {
          preferences.setString('currentUserAddress', adr);
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
