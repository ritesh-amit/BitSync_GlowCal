import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

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
                    color: gc,
                    boxShadow: [
                      BoxShadow(
                        color: gc.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 7,
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
                    'Thanks a lot for your Donate! Your Donate has been approved and we will send you an invoice soon',
                    textAlign: TextAlign.center,
                    style: txtS(textColor, 16, FontWeight.w600),
                  ),
                ),
                sh(54),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      elevation: 5,
                      color: gc,
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
                sh(50),
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
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 600),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return DialogBoxDonateDone();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
