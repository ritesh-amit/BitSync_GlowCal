import 'package:flutter/material.dart';
import 'package:gur/dialogBoxRequest.dart';
import 'package:gur/forgotPassword.dart';
import 'package:gur/signUp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'slidePage.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;

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
                        horizontal: SizeConfig.screenWidth * 53 / 414),
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
                          height: SizeConfig.screenHeight * 49 / 896,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              -SizeConfig.screenWidth * 21 / 414, 0, 0),
                          child: Text(
                            'Log-in',
                            style: GoogleFonts.playfairDisplay(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.screenWidth * 40 / 414,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 30 / 896,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                        Container(
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
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 20 / 896,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscuringCharacter: '*',
                            obscureText: !isVisible,
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
                              suffixIconConstraints: BoxConstraints(
                                minWidth: SizeConfig.screenWidth * 16 / 414,
                                minHeight: SizeConfig.screenHeight * 12 / 896,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.screenWidth * 15 / 414),
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
                                    size: SizeConfig.screenWidth * 16 / 414,
                                  ),
                                ),
                              ),
                              hintText: 'Password',
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
                          height: SizeConfig.screenHeight * 8 / 896,
                        ),
                        Row(
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                color: Color(0xffb5e8e9),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return ForgotPassword();
                                  }),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xffb5e8e9),
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeConfig.screenWidth * 14 / 414,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 25 / 896,
                        ),
                        MaterialButton(
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
                          height: SizeConfig.screenHeight * 48 / 896,
                          minWidth: SizeConfig.screenWidth * 304 / 414,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: SizeConfig.b * 0.0364,
                              fontSize: SizeConfig.screenWidth * 18 / 414,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 11 / 896,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(
                                color: Color(0xffb5e8e9),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(SlideRightRoute(page: SignUp()));
                              },
                              child: Text(
                                'Sign-up',
                                style: TextStyle(
                                  color: Color(0xffb5e8e9),
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeConfig.screenWidth * 14 / 414,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 23 / 896,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Color(0xffb5e8e9),
                              height: SizeConfig.screenHeight * 1 / 896,
                              width: SizeConfig.screenWidth * 100 / 414,
                            ),
                            InkWell(
                              onTap: null,
                              child: Text(
                                'Or login with',
                                style: TextStyle(
                                  color: Color(0xffb5e8e9),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.screenWidth * 14 / 414,
                                ),
                              ),
                            ),
                            Container(
                              color: Color(0xffb5e8e9),
                              height: SizeConfig.screenHeight * 1 / 896,
                              width: SizeConfig.screenWidth * 100 / 414,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 23 / 896,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                dialogBoxRequest(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.20),
                                      blurRadius: 24,
                                      spreadRadius: -7,
                                      offset: Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  child: Image.asset('images/google.png'),
                                  radius: SizeConfig.screenWidth * 24 / 414,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 30 / 896,
                        ),
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
                      ],
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      -SizeConfig.screenWidth * 80 / 414,
                      -SizeConfig.screenHeight * (896 - 311) / 896,
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
}
