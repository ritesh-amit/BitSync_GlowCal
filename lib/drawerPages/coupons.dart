import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Coupons extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;
    List images = [
      'images/22.png',
      'images/23.png',
      'images/21.png',
      'images/22.png',
      'images/23.png',
      'images/21.png',
      'images/22.png',
      'images/23.png',
      'images/21.png',
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: h * 60,
            padding: EdgeInsets.symmetric(horizontal: b * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: b * 4,
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: h * 30,
                        width: b * 30,
                        child: SvgPicture.asset(
                          'images/Arrow1.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                Text(
                  'My Coupons',
                  style: txtS(mc, 20, FontWeight.w600),
                ),
                Spacer(),
              ],
            ),
          ),
          sh(30),
          Container(
            height: h * 111,
            width: b * 370,
            margin: EdgeInsets.symmetric(horizontal: b * 20),
            padding: EdgeInsets.symmetric(horizontal: b * 15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                ),
              ],
              image: DecorationImage(
                image: AssetImage('images/amit.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(b * 6),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: b * 181,
                  child: Text(
                    'Get 50 points for each Kg food you donate',
                    style: txtS(Color(0xff266260), 17, FontWeight.w900),
                  ),
                ),
                Spacer(),
                Container(
                  height: h * 100,
                  width: b * 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: b * 2,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffb16668).withOpacity(0.4),
                          Color(0xffff9104).withOpacity(0.4),
                        ]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '900',
                        style: txtS(Colors.white, 30, FontWeight.w900),
                      ),
                      Text(
                        'Points Left',
                        style: txtS(Colors.white, 12, FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          sh(25),
          Padding(
            padding: EdgeInsets.only(left: b * 25),
            child: Text(
              'Your Coupons',
              style: txtS(textColor, 20, FontWeight.w600),
            ),
          ),
          sh(20),
          Expanded(
            child: ListView.builder(
              padding:
                  EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 5),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      dialogBoxCoupon(context, true);
                    },
                    child: Container(
                      height: h * 111,
                      width: b * 370,
                      margin: EdgeInsets.only(bottom: h * 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(b * 10),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void dialogBoxCoupon(BuildContext context, bool status) {
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: b * 0),
                      child: Text(
                        status
                            ? 'You want to redeem this Coupon?'
                            : 'You have already redeemed this coupon.. Try another coupon',
                        textAlign: TextAlign.center,
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                    ),
                    status ? sh(30) : sh(0),
                    status
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                elevation: 5,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(b * 36),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: b * 97,
                                  height: h * 40,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(b * 36),
                                    border: Border.all(
                                      color: Color(0xff28797c),
                                      width: b * 2,
                                    ),
                                  ),
                                  child: Text(
                                    'NO',
                                    style: txtS(
                                        Color(0xff28797c), 16, FontWeight.w600),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                elevation: 5,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                  dialogBoxReedemed(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(b * 36),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: b * 97,
                                  height: h * 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xff28797c),
                                    borderRadius: BorderRadius.circular(b * 36),
                                  ),
                                  child: Text(
                                    'YES',
                                    style:
                                        txtS(Colors.white, 16, FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : sh(0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
    );
  }

  void dialogBoxReedemed(BuildContext context) {
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
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
      },
      animationType: DialogTransitionType.rotate3D,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: h * SizeConfig.screenHeight / 896);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth / 412 * siz,
    );
  }
}
