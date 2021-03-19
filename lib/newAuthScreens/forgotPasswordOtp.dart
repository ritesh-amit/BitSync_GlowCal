import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gur/models/currentUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:toast/toast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswordOtp extends StatefulWidget {
  _ForgotPasswordOtpState createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
 
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
                    sh(50),
                    Image.asset('images/ill2.png', height: h * 350),
                    sh(40),
                    Text(
                      'We’ve sent a confirmation OTP over to',
                      textAlign: TextAlign.center,
                      style: txtS(textColor, 18, FontWeight.w400),
                    ),
                    Text(
                      'number ending with ***7654',
                      textAlign: TextAlign.center,
                      style: txtS(textColor, 18, FontWeight.w600),
                    ),
                    sh(85),
                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: b * 31,
                      fieldStyle: FieldStyle.underline,
                      style: txtS(textColor, 18, FontWeight.w600),
                      onChanged: (pin) {
                        print("Changed: ");
                      },
                      onCompleted: (pin) {
                        print("Completed: ");
                      },
                    ),
                    sh(50),
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
                          'Verify & Proceed',
                          style: txtS(Colors.white, 16, FontWeight.w700),
                        ),
                      ),
                    ),
                    sh(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t Receive OTP? ',
                          style: txtS(textColor, 16, FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Resend it!',
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
