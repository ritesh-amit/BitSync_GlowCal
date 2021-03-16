import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends StatefulWidget {
  final String phoneNo;

  OtpPage(this.phoneNo);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  String verificationCode = "";

  BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  void initState() {
    super.initState();
    otpVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text("Phone Verification"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  "Verify ${widget.phoneNo}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: const TextStyle(fontSize: 25, color: Colors.white),
                eachFieldWidth: 40,
                eachFieldHeight: 55,
                focusNode: otpFocusNode,
                controller: otpController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.scale,
                onSubmit: (otp) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  try {
                    await FirebaseAuth.instance.currentUser
                        .linkWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificationCode, smsCode: otp))
                        .then((value) {
                      if (value.user != null) {
                        preferences.setString(
                            'currentUserPhone', widget.phoneNo);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      } else {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text("Error, Try after sometime"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldkey.currentState.showSnackBar(SnackBar(
                      content: Text('Invalid OTP'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ),
            )
          ],
        ));
  }

  otpVerify() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        timeout: Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          auth.currentUser.linkWithCredential(credential).then((value) {
            if (value.user != null) {
              preferences.setString('currentUserPhone', widget.phoneNo);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return Home();
              }), (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, int forceResendingToken) async {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verificationCode = verificationId;
          });
        });
  }
}
