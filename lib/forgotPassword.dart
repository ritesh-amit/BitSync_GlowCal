import 'package:flutter/material.dart';
import 'package:gur/login.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'slidePage.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Transform(
                  transform: Matrix4.translationValues(
                      -SizeConfig.screenWidth * 0 / 414,
                      SizeConfig.screenHeight * 280 / 896,
                      0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 32 / 414),
                    height: SizeConfig.screenHeight * 585 / 896,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: gc,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          SizeConfig.screenWidth * 30 / 414,
                        ),
                        topRight: Radius.circular(
                          SizeConfig.screenWidth * 30 / 414,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 45 / 896,
                        ),
                        Text(
                          'Forgot password?',
                          style: GoogleFonts.playfairDisplay(
                            color: textColor,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.screenWidth * 40 / 414,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 35 / 896,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 21 / 414),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 18 / 414,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 23 / 414,
                            right: SizeConfig.screenWidth * 23 / 414,
                          ),
                          child: TextField(
                            style: TextStyle(
                              color: Color(0xffbde5e6),
                              fontSize: SizeConfig.screenWidth * 12 / 414,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
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
                              hintText: 'Your Email ID',
                              hintStyle: TextStyle(
                                color: Color(0xffbde5e6),
                                fontSize: SizeConfig.screenWidth * 12 / 414,
                                fontWeight: FontWeight.w400,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight * 9 / 896),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 30 / 896,
                        ),
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
                          height: SizeConfig.screenHeight * 48 / 896,
                          width: SizeConfig.screenWidth * 330 / 414,
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 23 / 414),
                          child: MaterialButton(
                            onPressed: () {
                              print('Add Session');
                            },
                            color: Color(0xffff9104),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 35 / 414,
                              ),
                            ),
                            elevation: 0,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: SizeConfig.screenWidth * 18 / 414,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 18 / 896,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(SlideRightRoute(page: Login()));
                              },
                              child: Text(
                                'Back to Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffb5e8e9),
                                  fontSize: SizeConfig.screenWidth * 14 / 414,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 183 / 414,
                              height: SizeConfig.screenHeight * 7 / 896,
                              decoration: BoxDecoration(
                                color: Color(0xffdee2e6),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.screenWidth * 15 / 414,
                                ),
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
                        SizedBox(
                          height: SizeConfig.screenHeight * 15 / 896,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      -SizeConfig.screenWidth * 80 / 414,
                      -SizeConfig.screenHeight * (585) / 896,
                      0),
                  child: Image.asset(
                    'images/girl.png',
                    height: SizeConfig.screenHeight * 350 / 896,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendVerificationCode() {}
}
