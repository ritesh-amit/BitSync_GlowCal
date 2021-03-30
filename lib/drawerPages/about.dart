import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/appBar2.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Bar2(),
          sh(25),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              child: Column(
                children: [
                  Text(
                    'Inspired by the United Nations Sustainable Development Goals and developed as a community welfare project.',
                    style: TextStyle(
                      letterSpacing: 1.25,
                      height: b * 1.5,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: b * 20,
                    ),
                  ),
                  sh(28),
                  Row(
                    children: [
                      SizedBox(width: b * 14),
                      Text(
                        'Terms of Service',
                        style: txtS(textColor, 16, FontWeight.w400),
                      ),
                      Spacer(),
                      Container(
                        height: h * 30,
                        width: b * 30,
                        child: SvgPicture.asset(
                          'images/Arrow2.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                      SizedBox(width: b * 60),
                    ],
                  ),
                  sh(13),
                  Container(
                    margin: EdgeInsets.only(left: b * 14, right: b * 60),
                    color: Color(0xffbdbdbd),
                    height: h * 0.3,
                  ),
                  sh(13),
                  Row(
                    children: [
                      SizedBox(width: b * 14),
                      Text(
                        'Privacy Policy',
                        style: txtS(textColor, 16, FontWeight.w400),
                      ),
                      Spacer(),
                      Container(
                        height: h * 30,
                        width: b * 30,
                        child: SvgPicture.asset(
                          'images/Arrow2.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                      SizedBox(width: b * 60),
                    ],
                  ),
                  sh(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: b * 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Technologies Used',
                            style: txtS(textColor, 20, FontWeight.w600),
                          ),
                          sh(20),
                          Text(
                            'Flutter by Google',
                            style: txtS(Color(0xff949494), 16, FontWeight.w400),
                          ),
                          sh(10),
                          Text(
                            'Firebase by Google',
                            style: txtS(Color(0xff949494), 16, FontWeight.w400),
                          ),
                          sh(10),
                          Text(
                            'Google Maps',
                            style: txtS(Color(0xff949494), 16, FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/splash2.png',
                          height: h * 127, width: b * 127),
                    ],
                  ),
                  sh(15),
                  Text(
                    'GlowCal',
                    style: txtS(textColor, 20, FontWeight.w600),
                  ),
                  sh(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Created with ',
                        style: txtS(textColor, 12, FontWeight.w400),
                      ),
                      SvgPicture.asset(
                        'images/Heart2.svg',
                        allowDrawingOutsideViewBox: true,
                      ),
                      Text(
                        ' by Team ',
                        style: txtS(textColor, 12, FontWeight.w400),
                      ),
                      Text(
                        ' BitSync',
                        style: txtS(textColor, 13, FontWeight.w800),
                      ),
                    ],
                  ),
                  sh(20),
                ],
              ),
            ),
          ),
        ]),
      ),
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
