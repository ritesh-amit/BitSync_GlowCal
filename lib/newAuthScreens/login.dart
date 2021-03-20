import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gur/main.dart';
import 'package:gur/newAuthScreens/choice.dart';
import 'package:gur/newAuthScreens/forgotPass.dart';
import 'package:gur/models/currentUser.dart';
import 'package:gur/newAuthScreens/signup.dart';
import 'package:gur/slidePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences preferences;
  String uid = "";
  String userToken = "";
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

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
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/ill1.png', height: h * 400),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: mc,
                              fontWeight: FontWeight.w700,
                              fontSize: b * 40,
                            ),
                          ),
                        ],
                      ),
                      sh(20),
                      Container(
                        height: h * 65,
                        width: b * 345,
                        decoration: BoxDecoration(
                          color: gc,
                          borderRadius: BorderRadius.circular(b * 10),
                        ),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: txtS(tc, 16, FontWeight.w500),
                          decoration: dec('Email Id'),
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
                          controller: pwdController,
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
                            hintText: 'Password',
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
                      sh(7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return ForgotPassword();
                                }),
                              );
                            },
                            child: Text(
                              'Forgot Password?  ',
                              style: txtS(textColor, 16, FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      sh(25),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            login();
                          },
                          color: mc,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(b * 10),
                          ),
                          elevation: 0,
                          height: h * 65,
                          minWidth: b * 345,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: h * 20,
                                  width: b * 20,
                                  child: SvgPicture.asset(
                                    'images/Group 23.svg',
                                    allowDrawingOutsideViewBox: true,
                                    width: h * 20,
                                    height: b * 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Login',
                                  style:
                                      txtS(Colors.white, 16, FontWeight.w700),
                                ),
                              ]),
                        ),
                      ),
                      sh(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: txtS(textColor, 16, FontWeight.w400),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Choice();
                              }));
                            },
                            child: Text(
                              'Sign-up',
                              style: txtS(mc, 16, FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  void login() async {
    String email = emailController.text;
    String pwd = pwdController.text;
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

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return Home();
        }), (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Toast.show("User not found", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else if (e.code == 'account-exists-with-different-credential') {
        String email = e.email;

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
      bool newUser = false;

      await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(googleUser.email)
          .then((signMethodList) {
        if (signMethodList.isEmpty)
          newUser = true;
        else
          newUser = false;
      }).then((x) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            if (newUser)
              setUserDataToDb(googleUser, value.user.uid);
            else
              getUserDataFromDb(value.user.uid);
          }

          Toast.show("Login Succesfull", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          preferences.setBool('isLoggedIn', true);

          preferences.setString('currentUserUID', value.user.uid);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return Home();
          }), (route) => false);
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email;

        List<String> userSignInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        Toast.show("Login Successfull", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        preferences.setBool('isLoggedIn', true);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Home();
        }));

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
      preferences.setString('currentUserType', snapshot.data()['userType']);

      if (snapshot.data()['phone'] != null) {
        preferences.setString('currentUserPhone', snapshot.data()['phone']);
      }
      preferences.setString('currentUserPhone', snapshot.data()['phone']);
      if (snapshot.data()['address'] != null) {
        preferences.setString('currentUserAddress', snapshot.data()['address']);
      }
    });
  }

  setUserDataToDb(googleUser, userId) {
    CurrentUser currentUser = CurrentUser(
        name: googleUser.displayName, email: googleUser.email, uid: userId);
    var map = currentUser.toMap();
    FirebaseFirestore.instance.collection('users').doc(userId).set(map);

    preferences.setString('currentUserName', googleUser.displayName);
    preferences.setString('currentUserEmail', googleUser.email);
  }
}
