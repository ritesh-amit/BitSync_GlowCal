import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/models/currentUser.dart';
import 'package:gur/newAuthScreens/otp.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  final String userType;
  SignUp(this.userType);
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String uType = 'ind';
  bool isVisible = false;
  bool isVisible2 = false;
  bool isIndividual = true;
  bool isOrg = false;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sh(95),
                      Text(
                        'Sign-up',
                        style: TextStyle(
                          color: mc,
                          fontWeight: FontWeight.w700,
                          fontSize: b * 40,
                        ),
                      ),
                      sh(20),
                      widget.userType == '0'
                          ? Text(
                              'NGO',
                              style: TextStyle(
                                letterSpacing: 1,
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: b * 18,
                              ),
                            )
                          : Text(
                              'Donor Type',
                              style: TextStyle(
                                letterSpacing: 1,
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: b * 18,
                              ),
                            ),
                      sh(25),
                      widget.userType == '0'
                          ? SizedBox()
                          : Row(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isIndividual = true;
                                          isOrg = false;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2.5),
                                        height: h * 22,
                                        width: b * 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: mc, width: b * 1.5),
                                        ),
                                        child: CircleAvatar(
                                            radius: b * 7,
                                            backgroundColor: isIndividual
                                                ? mc
                                                : Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: b * 10),
                                    Text(
                                      'Individual',
                                      style:
                                          txtS(textColor, 16, FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(width: b * 30),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isOrg = true;
                                          isIndividual = false;
                                          uType = 'org';
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2.5),
                                        height: h * 22,
                                        width: b * 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: mc, width: b * 1.5),
                                        ),
                                        child: CircleAvatar(
                                          radius: b * 7,
                                          backgroundColor:
                                              isOrg ? mc : Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: b * 10),
                                    Text(
                                      'Organization',
                                      style:
                                          txtS(textColor, 16, FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      sh(35),
                      Container(
                        height: h * 65,
                        width: b * 345,
                        decoration: BoxDecoration(
                          color: gc,
                          borderRadius: BorderRadius.circular(b * 10),
                        ),
                        child: TextField(
                          controller: nameController,
                          style: txtS(tc, 16, FontWeight.w500),
                          decoration:
                              dec(isOrg ? 'Name of Organization' : 'Name'),
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
                              left: b * 23,
                            ),
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
                          style: txtS(tc, 16, FontWeight.w500),
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
                            hintText: 'Confirm your password',
                            hintStyle: txtS(tc, 16, FontWeight.w400),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: h * 23, horizontal: b * 23),
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
                          style: txtS(tc, 16, FontWeight.w500),
                          decoration: dec('Mobile Number'),
                        ),
                      ),
                      sh(13),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            if (fieldValidation()) signUpEmail();
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
                                  'Sign-Up for Free',
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
                            'Already have an account?  ',
                            style: txtS(textColor, 16, FontWeight.w400),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return Login();
                              }), (route) => false);
                            },
                            child: Text(
                              'Login',
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

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  bool fieldValidation() {
    if (pwdController.text != confirmPwdController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Mismatch"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    } else if (nameController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Name can't be empty"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    } else if (emailController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Email"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    } else if (pwdController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password can't be empty"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    } else if (phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Phone no."),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    } else
      return true;
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

    bool newUser;
    await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(email)
        .then((authList) {
      if (authList.isEmpty) {
        print("New User");
        newUser = true;
      } else {
        print("Already Registered");
        newUser = false;
      }
    });

    String type;
    if (widget.userType == '0')
      type = 'ngo';
    else
      type = uType;

    if (!newUser) {
      Toast.show("Already Registered", context, duration: Toast.LENGTH_LONG);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return Login();
      }), (route) => false);
    } else {
      CurrentUser currentUser = CurrentUser(
          name: userName, email: email, phone: phone, userType: type);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Otp(phone, currentUser, pwd, widget.userType);
      }));
    }
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
