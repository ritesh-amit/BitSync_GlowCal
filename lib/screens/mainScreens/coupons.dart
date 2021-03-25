import 'package:flutter/material.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Column(children: [
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: h * 30,
                    width: b * 30,
                  ),
                ),
              ],
            ),
          ),
          sh(18),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: h * 111,
                      width: b * 370,
                      margin: EdgeInsets.only(bottom: h * 15),
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
                        borderRadius: BorderRadius.circular(b * 6),
                        color: Colors.white,
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
