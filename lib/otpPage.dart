import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/mainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    otpVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP Page',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
            ),
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
            )
          ],
        ),
      ),
    );
  }

  void otpVerify() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String phone = preferences.getString('currentUserPhone');
    print(phone);

    auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          auth.currentUser.linkWithCredential(credential);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return new MainMenu();
          }));
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          final code = otpController.text.trim();
          AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: code);

          auth.currentUser.linkWithCredential(credential);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return new MainMenu();
          }));
        },
        codeAutoRetrievalTimeout: (String code) {
          print('Inside Auto Code Retrieval');
        });
  }
}
