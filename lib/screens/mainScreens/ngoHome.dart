import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/drawer.dart';

class NgoHome extends StatefulWidget {
  _NgoHomeState createState() => _NgoHomeState();
}

class _NgoHomeState extends State<NgoHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController aboutController = TextEditingController();
  bool isAbout = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 896;
    var b = SizeConfig.screenWidth / 412;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCode(),
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
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        height: h * 30,
                        width: b * 30,
                        child: SvgPicture.asset(
                          'images/Chart.svg',
                          allowDrawingOutsideViewBox: true,
                          width: h * 20,
                          height: b * 20,
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                Text(
                  'Home',
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
                      width: h * 20,
                      height: b * 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(physics: BouncingScrollPhysics(), children: [
              sh(20),
              Row(children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: b * 20),
                      width: b * 145,
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
                        borderRadius: BorderRadius.circular(b * 12),
                      ),
                    ),
                    Positioned(
                      right: b * 30,
                      bottom: h * 7,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: b * 26,
                          height: h * 26,
                          decoration: BoxDecoration(
                            color: mc,
                            borderRadius: BorderRadius.circular(b * 6),
                          ),
                          child: Icon(MdiIcons.imageEdit,
                              color: Colors.white, size: b * 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: b * 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: b * 180,
                      child: Text(
                        'Raam Puri Ram Puri',
                        overflow: TextOverflow.ellipsis,
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                    ),
                    sh(20),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: b * 26,
                          height: h * 26,
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
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: b * 20),
                    height: h * 147,
                    decoration: BoxDecoration(
                      color: gc,
                      borderRadius: BorderRadius.circular(b * 6),
                    ),
                  ),
                  Positioned(
                    right: b * 30,
                    bottom: h * 7,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: b * 26,
                        height: h * 26,
                        decoration: BoxDecoration(
                          color: mc,
                          borderRadius: BorderRadius.circular(b * 6),
                        ),
                        child: Icon(MdiIcons.imageEdit,
                            color: Colors.white, size: b * 14),
                      ),
                    ),
                  ),
                ],
              ),
              sh(25),
              Container(
                margin: EdgeInsets.symmetric(horizontal: b * 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'About',
                          style: txtS(textColor, 20, FontWeight.w600),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isAbout = !isAbout;
                            });
                            print(isAbout);
                          },
                          child: Icon(MdiIcons.squareEditOutline,
                              color: rc, size: b * 20),
                        ),
                      ],
                    ),
                    sh(10),
                    isAbout
                        ? Text(
                            'About this ngo and what not not About this ngo and what not not About this ngo and what not not Aboutthis ngo and what not not About this ngo and whatnot not About this ngo and what not not  About this ngo and what not not',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: txtS(Color(0xff828282), 14, FontWeight.w500),
                          )
                        : Container(
                            width: b * 375,
                            height: h * 105,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffb9b9b9),
                                width: b * 1,
                              ),
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            child: TextField(
                              controller: aboutController,
                              style: txtS(textColor, 16, FontWeight.w500),
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Enter About',
                                hintStyle: txtS(
                                    Color(0xff828282), 14, FontWeight.w500),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: b * 10, vertical: h * 5),
                              ),
                              maxLines: 6,
                            ),
                          ),
                    sh(20),
                    Text(
                      'Contact',
                      style: txtS(textColor, 20, FontWeight.w600),
                    ),
                    sh(20),
                    Row(children: [
                      Container(
                        width: b * 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: h * 22,
                                  width: b * 22,
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
                              style: txtS(textColor, 14, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: b * 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: h * 22,
                                  width: b * 22,
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
                              style: txtS(textColor, 16, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    sh(20),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: b * 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: h * 22,
                                      width: b * 22,
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
                                sh(2),
                                Text(
                                  'adresss Address Adress Adress adress adresss',
                                  style: txtS(textColor, 14, FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: b * 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: h * 22,
                                      width: b * 22,
                                      child: SvgPicture.asset(
                                        'images/Calendar.svg',
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    SizedBox(width: b * 2),
                                    Text(
                                      'Date of Registration',
                                      style: txtS(rc, 14, FontWeight.w500),
                                    ),
                                  ],
                                ),
                                sh(2),
                                Text(
                                  '21-11-2020',
                                  style: txtS(textColor, 16, FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              sh(200),
            ]),
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
