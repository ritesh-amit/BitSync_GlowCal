import 'package:flutter/material.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutNgo extends StatefulWidget {
  _AboutNgoState createState() => _AboutNgoState();
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw "Could not launch $url";
  }
}

class _AboutNgoState extends State<AboutNgo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
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
                        onTap: () {},
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
                    'NGO Name',
                    style: txtS(mc, 20, FontWeight.w600),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: h * 30,
                      width: b * 30,
                      child: SvgPicture.asset(
                        'images/SendColor.svg',
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                sh(29),
                Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: b * 20),
                    width: b * 150,
                    height: h * 175,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 24,
                          spreadRadius: -7,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(b * 6),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: b * 140,
                          height: h * 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/ill1.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(b * 6),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Working Since',
                                style: txtS(textColor, 12, FontWeight.w400),
                              ),
                              Text(
                                '21/08/2020',
                                style: txtS(textColor, 12, FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: b * 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: b * 144,
                        child: Text(
                          'Raam Puri NGO ',
                          overflow: TextOverflow.ellipsis,
                          style: txtS(textColor, 20, FontWeight.w600),
                        ),
                      ),
                      sh(20),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: b * 28,
                            height: h * 28,
                            decoration: BoxDecoration(
                              color: mc,
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            child: Icon(Icons.restaurant,
                                color: Colors.white, size: b * 14),
                          ),
                          SizedBox(width: b * 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '12',
                                style: txtS(textColor, 16, FontWeight.w500),
                              ),
                              Text(
                                'Packages Delivered',
                                style: txtS(rc, 10, FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sh(20),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: b * 26,
                            height: h * 26,
                            decoration: BoxDecoration(
                              color: Color(0xff28797c),
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            child: Icon(Icons.verified,
                                color: Colors.white, size: b * 14),
                          ),
                          SizedBox(width: b * 10),
                          Text(
                            'Verified',
                            style: txtS(textColor, 16, FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
                sh(30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: b * 20),
                  height: h * 125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 24,
                        spreadRadius: -7,
                        offset: Offset(0, 6),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('images/ill1.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(b * 6),
                  ),
                ),
                sh(25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: b * 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                      sh(10),
                      Text(
                        'About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About ',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: txtS(Color(0xff828282), 14, FontWeight.w500),
                      ),
                      sh(30),
                      Text(
                        'Contact',
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                      sh(20),
                      Row(children: [
                        InkWell(
                          onTap: () {
                            launchUrl(
                                "mailto:ritesh.shuklalmp2018.com?subject=Regarding Ngo Information&body=Can I get information regarding your employees");
                          },
                          child: Container(
                            width: b * 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: h * 25,
                                      width: b * 25,
                                      child: SvgPicture.asset(
                                        'images/Message.svg',
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    SizedBox(width: b * 7),
                                    Text(
                                      'Email',
                                      style: txtS(rc, 14, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                sh(2),
                                Text(
                                  'ritesh.shuklalmp2018@gmail.com',
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(textColor, 13, FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl("tel:+916387246025");
                          },
                          child: Container(
                            width: b * 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: h * 25,
                                      width: b * 25,
                                      child: SvgPicture.asset(
                                        'images/Call.svg',
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    SizedBox(width: b * 7),
                                    Text(
                                      'Phone',
                                      style: txtS(rc, 14, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                sh(2),
                                Text(
                                  '6387246025',
                                  style: txtS(textColor, 13, FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      sh(30),
                      Container(
                        width: b * 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: h * 25,
                                  width: b * 25,
                                  child: SvgPicture.asset(
                                    'images/Location.svg',
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                                SizedBox(width: b * 7),
                                Text(
                                  'Address',
                                  style: txtS(rc, 14, FontWeight.w500),
                                ),
                              ],
                            ),
                            sh(3),
                            Text(
                              'Shastri Nagar, ghoshiyana road, near chitra medical center, lakhimpur kheri',
                              style: txtS(textColor, 13, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sh(200),
              ]),
            ),
          ]),
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
