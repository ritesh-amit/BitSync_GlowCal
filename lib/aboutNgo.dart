import 'package:flutter/material.dart';
import 'package:gur/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class AboutNgo extends StatefulWidget {
  _AboutNgoState createState() => _AboutNgoState();
}

class _AboutNgoState extends State<AboutNgo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 32 / 414),
            child: Column(children: [
              SizedBox(height: SizeConfig.screenHeight * 15 / 896),
              Row(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: SizeConfig.screenHeight * 25 / 896,
                          width: SizeConfig.screenWidth * 25 / 414,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mc,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 8 / 414),
                          ),
                          child: Icon(
                            MdiIcons.keyboardBackspace,
                            color: mc,
                            size: SizeConfig.screenWidth * 18 / 414,
                          ),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Text(
                    'NGO Name',
                    style: TextStyle(
                      color: mc,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.screenWidth * 20 / 414,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 32 / 896),
              Row(children: [
                Container(
                  width: SizeConfig.screenWidth * 144 / 414,
                  height: SizeConfig.screenHeight * 177 / 896,
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
                    borderRadius: BorderRadius.circular(
                      SizeConfig.screenWidth * 12 / 414,
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.screenWidth * 24 / 414),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 144 / 414,
                      child: FittedBox(
                        child: Text(
                          'Raam Puri NGO ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenWidth * 20 / 414,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 21 / 896),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.screenWidth * 26 / 414,
                          height: SizeConfig.screenHeight * 26 / 896,
                          decoration: BoxDecoration(
                            color: mc,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffff9001),
                                blurRadius: 24,
                                spreadRadius: -9,
                                offset: Offset(0, 8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 6 / 414,
                            ),
                          ),
                          child: Icon(
                            Icons.food_bank,
                            color: Colors.white,
                            size: SizeConfig.screenWidth * 14 / 414,
                          ),
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 7 / 414),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 16 / 414,
                              ),
                            ),
                            Text(
                              'Packages Delivered',
                              style: TextStyle(
                                color: rc,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.screenWidth * 10 / 414,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 22 / 896),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.screenWidth * 26 / 414,
                          height: SizeConfig.screenHeight * 26 / 896,
                          decoration: BoxDecoration(
                            color: gc,
                            boxShadow: [
                              BoxShadow(
                                color: gc,
                                blurRadius: 24,
                                spreadRadius: -9,
                                offset: Offset(0, 8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 6 / 414,
                            ),
                          ),
                          child: Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: SizeConfig.screenWidth * 14 / 414,
                          ),
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 7 / 414),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 16 / 414,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              SizedBox(height: SizeConfig.screenHeight * 28.35 / 896),
              Container(
                width: SizeConfig.screenWidth * 350 / 414,
                height: SizeConfig.screenHeight * 125 / 896,
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
                  borderRadius: BorderRadius.circular(
                    SizeConfig.screenWidth * 12 / 414,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 26 / 896),
              Text(
                'About',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.screenWidth * 20 / 414,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 8 / 896),
              Text(
                'About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About About ',
                style: TextStyle(
                  color: Color(0xff828282),
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.screenWidth * 14 / 414,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 31 / 896),
              Text(
                'Contact',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.screenWidth * 20 / 414,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 17 / 896),
              Row(children: [
                Container(
                  width: SizeConfig.screenWidth * 250 / 414,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: rc,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 7 / 414),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: rc,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 14 / 414,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ritesh.shuklalmp2018@gmail.com',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth * 14 / 414,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 100 / 414,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: rc,
                            size: SizeConfig.screenWidth * 15 / 414 * 1.3,
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 7 / 414),
                          Text(
                            'Phone',
                            style: TextStyle(
                              color: rc,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 14 / 414,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '6387246025',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth * 14 / 414,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: SizeConfig.screenHeight * 28 / 896),
              Container(
                width: SizeConfig.screenWidth * 300 / 414,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: rc,
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 7 / 414),
                        Text(
                          'Address',
                          style: TextStyle(
                            color: rc,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 14 / 414,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Shastri Nagar, ghoshiyana road, near chitra medical center, lakhimpur kheri',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 14 / 414,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 200 / 896),
            ]),
          ),
        ),
      ),
    );
  }
}
