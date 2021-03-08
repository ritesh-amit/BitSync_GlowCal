import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/dialogboxes/dialogBoxRequest.dart';
import 'package:gur/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

      if (preferences.containsKey('currentUserAddress'))
        address = preferences.getString('currentUserAddress');
      else
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
    //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: DrawerCode(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  sh(20),
                  Row(
                    children: [
                      SizedBox(width: b * 32),
                      Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Container(
                              height: h * 35,
                              width: b * 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: mc,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(b * 8),
                              ),
                              child: Icon(
                                MdiIcons.sortVariant,
                                color: mc,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: b * 105),
                      Text(
                        'Profile',
                        style: txtS(mc, 20, FontWeight.w600),
                      ),
                    ],
                  ),
                  sh(25),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xffb9b9b9),
                          size: b * 18,
                        ),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Name',
                              style: txtS(rc, 14, FontWeight.w500),
                            ),
                            sh(6),
                            Text(
                              userName,
                              style: txtS(textColor, 16, FontWeight.w500),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color(0xffb9b9b9),
                          size: b * 18,
                        ),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Phone Number',
                              style: txtS(rc, 14, FontWeight.w500),
                            ),
                            sh(6),
                            Text(
                              userPhone,
                              style: txtS(textColor, 16, FontWeight.w500),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 17, vertical: h * 11),
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.mail,
                          color: !isEmail ? rc : textColor,
                          size: b * 18,
                        ),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              !isEmail ? 'Email' : "Update Email",
                              style: txtS(!isEmail ? rc : textColor, 14,
                                  FontWeight.w500),
                            ),
                            sh(6),
                            !isEmail
                                ? Text(
                                    email,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                  )
                                : Text(
                                    'Email',
                                    style: txtS(rc, 14, FontWeight.w500),
                                  ),
                            isEmail
                                ? Container(
                                    width: b * 250,
                                    child: TextField(
                                      style:
                                          txtS(textColor, 14, FontWeight.w500),
                                      decoration: dec('Your Email ID'),
                                    ),
                                  )
                                : SizedBox(),
                            sh(11),
                            isEmail
                                ? Padding(
                                    padding: EdgeInsets.only(left: b * 160),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
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
                                  isEmail = !isEmail;
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
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock,
                          color: !isPass ? rc : textColor,
                          size: b * 18,
                        ),
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
                                : Text(
                                    'Old Password',
                                    style: txtS(rc, 14, FontWeight.w500),
                                  ),
                            isPass
                                ? Container(
                                    width: b * 250,
                                    child: TextFormField(
                                      controller: oldPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible,
                                      style:
                                          txtS(textColor, 16, FontWeight.w500),
                                      decoration: deco('Your Old Password', 1),
                                    ),
                                  )
                                : SizedBox(),
                            isPass ? sh(10) : SizedBox(),
                            isPass
                                ? Container(
                                    width: b * 250,
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
                                    width: b * 250,
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
                            sh(11),
                            isPass
                                ? Padding(
                                    padding: EdgeInsets.only(left: b * 160),
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
                                        //dialogBoxRequest(context);
                                      },
                                      child: Container(
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
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xffb9b9b9),
                          size: b * 18,
                        ),
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
                            Container(
                              width: b * 235,
                              child: Text(
                                !isAddress ? address : "Address",
                                style: txtS(!isAddress ? textColor : rc, 16,
                                    FontWeight.w500),
                              ),
                            ),
                            isAddress
                                ? Container(
                                    width: b * 250,
                                    child: TextField(
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
                                  )
                                : SizedBox(),
                            sh(11),
                            isAddress
                                ? Padding(
                                    padding: EdgeInsets.only(left: b * 160),
                                    child: InkWell(
                                      onTap: () {
                                        preferences.setString(
                                            'currentUserAddress',
                                            addressController.text.trim());
                                        setState(() {
                                          isAddress = !isAddress;
                                        });
                                      },
                                      child: Container(
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
                  sh(9),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: b * 15, vertical: h * 15),
                    width: b * 350,
                    decoration: bord(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xffb9b9b9),
                          size: b * 18,
                        ),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Verification',
                              style: txtS(rc, 14, FontWeight.w500),
                            ),
                            sh(9),
                            Container(
                              width: b * 235,
                              child: Text(
                                'Account Not Verified(click to request verification)',
                                style: txtS(textColor, 16, FontWeight.w500),
                              ),
                            ),
                            sh(12),
                            Padding(
                              padding: EdgeInsets.only(left: b * 60),
                              child: InkWell(
                                onTap: () {
                                  dialogBoxRequest(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: b * 17, vertical: h * 7),
                                  width: b * 215,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mc,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(b * 18),
                                  ),
                                  child: Row(children: [
                                    Text(
                                      'Request for verification',
                                      style: txtS(mc, 12, FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: mc,
                                      size: b * 18,
                                    ),
                                  ]),
                                ),
                              ),
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

  Icon ediB() {
    return Icon(
      Icons.edit,
      color: Color(0xffb9b9b9),
      size: SizeConfig.screenWidth / 414 * 22,
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
      hintStyle: txtS(textColor, 14, FontWeight.w500),
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
        color: Color(0xffb9b9b9),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(SizeConfig.screenWidth / 414 * 18),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  void pwdChangeRequest(String pwd, String newPwd) {
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
}
