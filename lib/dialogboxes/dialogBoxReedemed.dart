import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogBoxRedeemed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: h * 20),
            padding: EdgeInsets.symmetric(horizontal: b * 22),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: b * 0),
              child: Text(
                'Thanks for redeeming this coupon.. You can now avail it\'s benefits!!',
                textAlign: TextAlign.center,
                style: txtS(textColor, 20, FontWeight.w600),
              ),
            ),
          ),
        ],
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

void dialogBoxRedeemed(BuildContext context) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DialogBoxRedeemed();
    },
    animationType: DialogTransitionType.rotate3D,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 500),
  );
}
