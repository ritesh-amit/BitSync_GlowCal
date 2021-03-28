import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color(0xffe5e5e5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Transform(
                  transform: Matrix4.translationValues(-b * 0, h * 280, 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 32),
                    height: h * 585,
                    width: b * 414,
                    decoration: BoxDecoration(
                      color: gc,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(b * 30),
                        topRight: Radius.circular(b * 30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(45),
                        Text(
                          'Forgot password?',
                          style: GoogleFonts.playfairDisplay(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: b * 40,
                          ),
                        ),
                        sh(35),
                        Padding(
                          padding: EdgeInsets.only(left: b * 21),
                          child: Text(
                            'Email',
                            style: txtS(textColor, 18, FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: b * 23, right: b * 23),
                          child: TextField(
                            controller: emailController,
                            style: txtS(Color(0xffb5e8e9), 16, FontWeight.w500),
                            decoration: dec('Your Email ID'),
                          ),
                        ),
                        sh(30),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff2d2c32).withOpacity(0.20),
                                blurRadius: 24,
                                spreadRadius: -7,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          height: h * 48,
                          width: b * 330,
                          padding: EdgeInsets.only(left: b * 23),
                          child: MaterialButton(
                            onPressed: () {
                              sendVerificationLink();
                            },
                            color: mc,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(b * 35),
                            ),
                            elevation: 0,
                            child: Text(
                              'Submit',
                              style: txtS(Colors.white, 18, FontWeight.w500),
                            ),
                          ),
                        ),
                        sh(18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Back to Login',
                                style: txtS(
                                    Color(0xffb5e8e9), 14, FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: b * 183,
                              height: h * 7,
                              decoration: BoxDecoration(
                                color: Color(0xffdee2e6),
                                borderRadius: BorderRadius.circular(b * 15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sh(15),
                      ],
                    ),
                  ),
                ),
                Transform(
                  transform:
                      Matrix4.translationValues(-b * 80, -h * (896 - 400), 0),
                  child: Image.asset(
                    'images/girl.png',
                    height: h * 250,
                  ),
                ),
              ],
            ),
          ),
        ),
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

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffb5e8e9).withOpacity(0.36),
          width: SizeConfig.screenWidth * 1 / 414,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffb5e8e9).withOpacity(0.36),
          width: SizeConfig.screenWidth * 1 / 414,
        ),
      ),
      hintText: txt,
      hintStyle: TextStyle(
        color: Color(0xffbde5e6),
        fontSize: SizeConfig.screenWidth * 12 / 414,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 9 / 896),
    );
  }

  void sendVerificationLink() async {
    String email = emailController.text;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      _scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Password reset link is sent to your email"),
        backgroundColor: Colors.yellow,
      ));
    });
  }
}
