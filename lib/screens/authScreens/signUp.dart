import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/models/currentUser.dart';
import 'package:gur/screens/authScreens/login.dart';
import 'package:gur/screens/mainMenu.dart';
import 'package:gur/screens/authScreens/otpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = false;
  bool isVisible2 = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  SharedPreferences preferences;
  String uid = "";
  String userToken = "";

  AutovalidateMode phoneValidator = AutovalidateMode.disabled;
  AutovalidateMode pwdValidator = AutovalidateMode.disabled;

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
                      SizeConfig.screenHeight * 270 / 896,
                      0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 53 / 414),
                    height: SizeConfig.screenHeight * 740 / 896,
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
                          height: SizeConfig.screenHeight * 35 / 896,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              -SizeConfig.screenWidth * 23 / 414, 0, 0),
                          child: Text(
                            'Sign-up',
                            style: GoogleFonts.playfairDisplay(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.screenWidth * 40 / 414,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 35 / 896,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: nameController,
                            style: TextStyle(
                              color: Color(0xffbde5e6),
                              fontSize: SizeConfig.screenWidth * 12 / 414,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight * 9 / 896),
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
                              hintText: 'Your Name',
                              hintStyle: TextStyle(
                                color: Color(0xffbde5e6),
                                fontSize: SizeConfig.screenWidth * 12 / 414,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                            controller: pwdController,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(
                              color: Color(0xffbde5e6),
                              fontSize: SizeConfig.screenWidth * 12 / 414,
                              fontWeight: FontWeight.w400,
                            ),
                            obscuringCharacter: '*',
                            obscureText: !isVisible,
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
                              contentPadding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 9 / 896,
                                bottom: SizeConfig.screenHeight * 9 / 896,
                                right: SizeConfig.screenWidth * 12 / 414,
                              ),
                            ),
                            maxLines: 1,
                            minLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 6 / 896,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 30 / 896,
                        ),
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            autovalidateMode: pwdValidator,
                            validator: (String value) {
                              if (value != pwdController.text)
                                return "Password did not match";
                              else
                                return null;
                            },
                            onEditingComplete: () {
                              pwdValidator = AutovalidateMode.always;
                            },
                            controller: confirmPwdController,
                            obscuringCharacter: '*',
                            obscureText: !isVisible2,
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
                                      isVisible2 = !isVisible2;
                                    });
                                  },
                                  child: Icon(
                                    isVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                    size: SizeConfig.screenWidth * 16 / 414,
                                  ),
                                ),
                              ),
                              hintText: 'Confirm your password',
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
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            autovalidateMode: phoneValidator,
                            validator: (String value) {
                              if (value.length != 10)
                                return "Invalid phone number";
                              else
                                return null;
                            },
                            onFieldSubmitted: (String value) {
                              phoneValidator = AutovalidateMode.always;
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
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
                              hintText: 'Mobile Number',
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
                          height: SizeConfig.screenHeight * 11 / 896,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style: TextStyle(
                                color: Color(0xffb5e8e9),
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return Login();
                                  }),
                                );
                              },
                              child: Text(
                                'Login',
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
                          height: SizeConfig.screenHeight * 35 / 896,
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
                          child: MaterialButton(
                            onPressed: () {
                              print('Add Session');
                              if (pwdController.text !=
                                  confirmPwdController.text) {
                              } else
                                signUpEmail();
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
                              'Sign-Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: SizeConfig.b * 0.0364,
                                fontSize: SizeConfig.screenWidth * 18 / 414,
                              ),
                            ),
                          ),
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
                      -SizeConfig.screenHeight * (750) / 896,
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

  void signUpEmail() async {
    String userName = nameController.text;
    String email = emailController.text;
    String pwd = pwdController.text;
    String phone = phoneController.text;
    phone = "+91" + phone;

    preferences = await SharedPreferences.getInstance();

    print(
        'User Name: $userName \nEmail: $email \nPassword: $pwd \nPhone: $phone');

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pwd)
          .then((value) {
        uid = value.user.uid;
        userToken = 'NA';
      });

      preferences.setBool('isLoggedIn', true);
      Toast.show('Welcome $userName', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      addUsertoDB(userName, email, pwd, phone);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return OtpPage(phone);
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Toast.show('The account already exists for that email', context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }

    preferences.setString('currentUserName', userName);
    preferences.setString('currentUserEmail', email);
  }

  void addUsertoDB(String userName, String email, String pwd, String phone) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String userName = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    CurrentUser currentUser =
        CurrentUser(name: userName, email: email, phone: phone, uid: uid);

    Map<String, dynamic> map = currentUser.toMap();

    try {
      firestore.collection('users').doc(uid).set(map).whenComplete(() {
        print("User added to DB");
      });
    } catch (e) {
      print(e);
    }
  }
}
