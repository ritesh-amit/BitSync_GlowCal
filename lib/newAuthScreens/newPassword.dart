import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/newAuthScreens/forgotPass.dart';
import 'package:gur/models/currentUser.dart';
import 'package:gur/newAuthScreens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  SharedPreferences preferences;
  String uid = "";
  String userToken = "";
  bool isVisible = false;
  bool isVisible2 = false;
  TextEditingController newpassController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  AutovalidateMode phoneValidator = AutovalidateMode.disabled;
  AutovalidateMode pwdValidator = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: b * 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/ill3.png', height: h * 390),
                    sh(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: b * 300,
                          child: Text(
                            'Enter new Password',
                            maxLines: 2,
                            style: txtS(mc, 40, FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    sh(30),
                    Container(
                      height: h * 65,
                      width: b * 345,
                      decoration: BoxDecoration(
                        color: gc,
                        borderRadius: BorderRadius.circular(b * 10),
                      ),
                      child: TextField(
                        controller: newpassController,
                        keyboardType: TextInputType.visiblePassword,
                        style: txtS(tc, 16, FontWeight.w500),
                        obscuringCharacter: '*',
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIconConstraints: BoxConstraints(
                              minWidth: b * 16, minHeight: h * 12),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: b * 15),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                                size: b * 16,
                              ),
                            ),
                          ),
                          hintText: 'New Password',
                          hintStyle: txtS(tc, 16, FontWeight.w400),
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: h * 23,
                              bottom: h * 23,
                              right: b * 23,
                              left: b * 23),
                        ),
                      ),
                    ),
                    sh(13),
                    Container(
                      height: h * 65,
                      width: b * 345,
                      decoration: BoxDecoration(
                        color: gc,
                        borderRadius: BorderRadius.circular(b * 10),
                      ),
                      child: TextField(
                        controller: confirmController,
                        keyboardType: TextInputType.visiblePassword,
                        style: txtS(tc, 16, FontWeight.w500),
                        obscuringCharacter: '*',
                        obscureText: !isVisible2,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIconConstraints: BoxConstraints(
                              minWidth: b * 16, minHeight: h * 12),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: b * 15),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isVisible2 = !isVisible2;
                                });
                              },
                              child: Icon(
                                isVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                                size: b * 16,
                              ),
                            ),
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: txtS(tc, 16, FontWeight.w400),
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: h * 23,
                              bottom: h * 23,
                              right: b * 23,
                              left: b * 23),
                        ),
                      ),
                    ),
                    sh(13),
                    Container(
                      child: MaterialButton(
                        onPressed: () {},
                        color: mc,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(b * 10),
                        ),
                        elevation: 0,
                        height: h * 65,
                        minWidth: b * 345,
                        child: Text(
                          'Save',
                          style: txtS(Colors.white, 16, FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: tc,
        fontSize: SizeConfig.screenWidth * 16 / 414,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 23 / 896,
          horizontal: SizeConfig.screenWidth * 23 / 414),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }
}
