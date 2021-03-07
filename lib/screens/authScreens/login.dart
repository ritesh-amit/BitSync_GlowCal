import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gur/screens/authScreens/forgotPassword.dart';
import 'package:gur/main.dart';
import 'package:gur/screens/authScreens/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../mainMenu.dart';
import '../../slidePage.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdEditingController = TextEditingController();
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
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
                              controller: emailTextController,
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
                                    vertical:
                                        SizeConfig.screenHeight * 9 / 896),
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
                              controller: pwdEditingController,
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
                                    vertical:
                                        SizeConfig.screenHeight * 9 / 896),
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
                              login();
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
                                  print("Google Sign In");
                                  googleSignIn();
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
      ),
    );
  }

  void login() async {
    String email = emailTextController.text;
    String pwd = pwdEditingController.text;
    preferences = await SharedPreferences.getInstance();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd)
          .then((credential) {
        Toast.show("Login Succesfull", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        preferences.setBool('isLoggedIn', true);
        getUserDataFromDb(credential.user.uid);
        preferences.setString('currentUserUID', credential.user.uid);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MainMenu();
        }));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Toast.show("User not found", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else if (e.code == 'account-exists-with-different-credential') {
        String email = e.email;
        AuthCredential pendingCredential = e.credential;

        List<String> userSignInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        print(userSignInMethods);
      } else if (e.code == 'wrong-password') {
        Toast.show("Wrong Password", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Failure, Kindly login after sometime", context,
            duration: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e);
    }
  }

  void googleSignIn() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    preferences = await SharedPreferences.getInstance();

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        if (value.user != null) {
          getUserDataFromDb(value.user.uid);

          Toast.show("Login Succesfull", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          preferences.setBool('isLoggedIn', true);
          getUserDataFromDb(value.user.uid);
          preferences.setString('currentUserUID', value.user.uid);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MainMenu();
          }));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email;

        List<String> userSignInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        print(userSignInMethods);
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  void getUserDataFromDb(String userUid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('users').doc(userUid).snapshots().listen((snapshot) {
      preferences.setString('currentUserName', snapshot.data()['name']);
      preferences.setString('currentUserEmail', snapshot.data()['email']);

      if (snapshot.data()['phone'] != null) {
        preferences.setString('currentUserPhone', snapshot.data()['phone']);
      }
      preferences.setString('currentUserPhone', snapshot.data()['phone']);
      if (snapshot.data()['address'] != null) {
        preferences.setString('currentUserAddress', snapshot.data()['address']);
      }
    });
  }
}
