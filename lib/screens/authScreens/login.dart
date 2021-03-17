import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gur/main.dart';
import 'package:gur/screens/authScreens/forgotPassword.dart';
import 'package:gur/screens/authScreens/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
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
                    transform: Matrix4.translationValues(-b * 0, h * 280, 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: b * 53),
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
                          sh(49),
                          Transform(
                            transform: Matrix4.translationValues(-b * 21, 0, 0),
                            child: Text(
                              'Log-in',
                              style: GoogleFonts.playfairDisplay(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: b * 40,
                              ),
                            ),
                          ),
                          sh(30),
                          Text(
                            'Email',
                            style: txtS(textColor, 18, FontWeight.w500),
                          ),
                          Container(
                            child: TextField(
                              controller: emailTextController,
                              style:
                                  txtS(Color(0xffb5e8e9), 16, FontWeight.w500),
                              decoration: dec('Your Email Id'),
                            ),
                          ),
                          sh(20),
                          Text(
                            'Password',
                            style: txtS(textColor, 18, FontWeight.w500),
                          ),
                          Container(
                            child: TextField(
                              controller: pwdEditingController,
                              obscuringCharacter: '*',
                              obscureText: !isVisible,
                              style:
                                  txtS(Color(0xffb5e8e9), 16, FontWeight.w500),
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
                                hintStyle: txtS(
                                    Color(0xffb5e8e9), 12, FontWeight.w400),
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: h * 9),
                              ),
                            ),
                          ),
                          sh(8),
                          Row(
                            children: [
                              Text(''),
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
                                  style: txtS(
                                      Color(0xffb5e8e9), 14, FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          sh(25),
                          MaterialButton(
                            onPressed: () {
                              print('Add Session');
                              login();
                            },
                            color: mc,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(b * 35),
                            ),
                            elevation: 0,
                            height: h * 48,
                            minWidth: b * 304,
                            child: Text(
                              'Login',
                              style: txtS(Colors.white, 18, FontWeight.w500),
                            ),
                          ),
                          sh(11),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ? ',
                                style: txtS(
                                    Color(0xffb5e8e9), 14, FontWeight.w400),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(SlideRightRoute(page: SignUp()));
                                },
                                child: Text(
                                  'Sign-up',
                                  style: txtS(
                                      Color(0xffb5e8e9), 14, FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          sh(23),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Color(0xffb5e8e9),
                                height: h * 1,
                                width: b * 100,
                              ),
                              InkWell(
                                onTap: null,
                                child: Text(
                                  'Or login with',
                                  style: txtS(
                                      Color(0xffb5e8e9), 14, FontWeight.w500),
                                ),
                              ),
                              Container(
                                color: Color(0xffb5e8e9),
                                height: h * 1,
                                width: b * 100,
                              ),
                            ],
                          ),
                          sh(23),
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
                                    radius: b * 24,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sh(30),
                        ],
                      ),
                    ),
                  ),
                  Transform(
                    transform:
                        Matrix4.translationValues(-b * 80, -h * (896 - 390), 0),
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

  UnderlineInputBorder bor() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffb5e8e9).withOpacity(0.36),
        width: SizeConfig.screenWidth / 414 * 1,
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
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


      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return Home();
        }),
      );

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
