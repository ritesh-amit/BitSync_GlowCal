import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/models/currentUser.dart';
import 'package:gur/screens/authScreens/login.dart';
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
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Transform(
                  transform: Matrix4.translationValues(-b * 0, h * 270, 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 53),
                    height: h * 740,
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
                        sh(35),
                        Transform(
                          transform: Matrix4.translationValues(-b * 23, 0, 0),
                          child: Text(
                            'Sign-up',
                            style: GoogleFonts.playfairDisplay(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: b * 40,
                            ),
                          ),
                        ),
                        sh(35),
                        Text(
                          'Name',
                          style: txtS(textColor, 18, FontWeight.w500),
                        ),
                        Container(
                          child: TextField(
                            controller: nameController,
                            style: txtS(Color(0xffbde5e6), 16, FontWeight.w500),
                            decoration: dec('Your Name'),
                          ),
                        ),
                        sh(30),
                        Text(
                          'Email',
                          style: txtS(textColor, 18, FontWeight.w500),
                        ),
                        Container(
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: txtS(Color(0xffbde5e6), 16, FontWeight.w500),
                            decoration: dec('Your Email Id'),
                          ),
                        ),
                        sh(30),
                        Text(
                          'Password',
                          style: txtS(textColor, 18, FontWeight.w500),
                        ),
                        Container(
                          child: TextField(
                            controller: pwdController,
                            keyboardType: TextInputType.visiblePassword,
                            style: txtS(Color(0xffbde5e6), 16, FontWeight.w500),
                            obscuringCharacter: '*',
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                              enabledBorder: bor(),
                              focusedBorder: bor(),
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
                              hintText: 'Password',
                              hintStyle:
                                  txtS(Color(0xffbde5e6), 12, FontWeight.w400),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                top: h * 9,
                                bottom: h * 9,
                                right: b * 12,
                              ),
                            ),
                          ),
                        ),
                        sh(30),
                        Text(
                          'Confirm Password',
                          style: txtS(textColor, 18, FontWeight.w500),
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
                            style: txtS(Color(0xffbde5e6), 16, FontWeight.w500),
                            decoration: InputDecoration(
                              enabledBorder: bor(),
                              focusedBorder: bor(),
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
                              hintText: 'Confirm your password',
                              hintStyle:
                                  txtS(Color(0xffbde5e6), 12, FontWeight.w400),
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: h * 9),
                            ),
                          ),
                        ),
                        sh(30),
                        Text(
                          'Mobile Number',
                          style: txtS(textColor, 18, FontWeight.w500),
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
                            style: txtS(Color(0xffbde5e6), 16, FontWeight.w500),
                            decoration: dec('Mobile Number'),
                          ),
                        ),
                        sh(11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style:
                                  txtS(Color(0xffb5e8e9), 14, FontWeight.w400),
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
                                style: txtS(
                                    Color(0xffb5e8e9), 14, FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        sh(35),
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
                            color: mc,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(b * 35),
                            ),
                            elevation: 0,
                            height: h * 48,
                            minWidth: b * 304,
                            child: Text(
                              'Sign-Up',
                              style: txtS(Colors.white, 18, FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform(
                  transform:
                      Matrix4.translationValues(-b * 80, -h * (896 - 230), 0),
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

  UnderlineInputBorder bor() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffb5e8e9).withOpacity(0.36),
        width: SizeConfig.screenWidth / 414 * 1,
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

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
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
