import 'package:flutter/material.dart';
import 'package:gur/appBar2.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Mission extends StatelessWidget {
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Mission',
                    style: txtS(textColor, 20, FontWeight.w600),
                  ),
                  sh(20),
                  Text(
                    'The United Nations published its Food Waste index report 2021 on March 5th, 2021. It states that about 931 Million tonnes of food were wasted globally in year 2019. The report also indicates about 8-10% of the global greenhouse gas emissions are associated with the food that was not consumed and it may feed the adverse climate change of the planet in the long run. According to the report, while 13% of the waste comes from retail services and 26% from the food services, 61% of it came from the households. If we consider the three most populous countries, it’s 64 kg per capita per year in China, 50 kg per capita per year in India and 59 Kg per capita per year in the US.The surprising fact is that there was a substantial amount of food wasted in every country that has measured it, regardless of the income level.\nThe above data is only for the consumer level waste. If we consider the waste from the production level, it accounts for 121 kg per capita per year as a world average.\n\nOur mission is to save  as much food as we can so that more people can be fed with the same amount of food, just by better planning and some generous help from you.\nIt’s OK to prepare some extra food, but it’s really great to give it to someone who needs it when you’ve in excess.',
                    style: txtS(Colors.black87, 16, FontWeight.w400),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset('images/splash2.png',
                              height: h * 50, width: b * 50),
                          sh(7),
                          Text(
                            'GlowCal',
                            style: txtS(textColor, 10, FontWeight.w700),
                          ),
                          Text(
                            'V 1.1.0',
                            style: txtS(textColor, 10, FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(width: b * 20),
                      Container(
                        width: b * 1,
                        height: h * 75,
                        color: Color(0xff979797),
                      ),
                      SizedBox(width: b * 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Created with ',
                                style: txtS(textColor, 14, FontWeight.w400),
                              ),
                              SvgPicture.asset(
                                'images/Heart2.svg',
                                allowDrawingOutsideViewBox: true,
                                width: h * 23,
                                height: b * 23,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'by Team ',
                                style: txtS(textColor, 14, FontWeight.w400),
                              ),
                              Text(
                                'BitSync',
                                style: txtS(textColor, 14, FontWeight.w800),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  sh(15),
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
