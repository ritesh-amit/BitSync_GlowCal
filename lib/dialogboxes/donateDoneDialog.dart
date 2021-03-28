import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogBoxDonateDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: h * 20),
            padding: EdgeInsets.symmetric(horizontal: b * 22),
            child: Column(
              children: [
                sh(25),
                Container(
                  height: h * 140,
                  width: b * 135,
                  decoration: BoxDecoration(
                    color: Color(0xff28797c),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff28797c).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(b * 30),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: b * 80,
                  ),
                ),
                sh(47),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: b * 36),
                  child: Text(
                    'Thanks a lot for your Donation! Your donation request has been made and we will notify you as soon as the NGO accepts your request!\n\n Thanks for making people happier',
                    textAlign: TextAlign.center,
                    style: txtS(textColor, 16, FontWeight.w600),
                  ),
                ),
                sh(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      elevation: 5,
                      color: Color(0xff28797c),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      minWidth: b * 97,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(b * 36),
                      ),
                      child: Text(
                        'Close',
                        style: txtS(Colors.white, 16, FontWeight.w600),
                      ),
                    )
                  ],
                ),
                sh(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
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

void dialogBoxDonateDone(BuildContext context) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DialogBoxDonateDone();
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 400),
  );
}
