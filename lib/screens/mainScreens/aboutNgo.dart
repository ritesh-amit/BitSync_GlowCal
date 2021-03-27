import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutNgo extends StatefulWidget {
  final String uidNGO;

  AboutNgo({this.uidNGO});
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
  String uid = '';
  String ngoName = 'NA';
  String email = "NA";
  String phone = 'NA';
  String address = 'NA';
  String photo = 'NA';
  String photo2 = 'NA';
  String headImageURL = '';
  String regDate = "NA";
  String summary = 'NA';
  Timestamp timestamp;

  @override
  void initState() {
    super.initState();

    getDataFromDb();
  }

  getDataFromDb() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uidNGO)
        .snapshots()
        .listen((snap) {
      setState(() {
        ngoName = snap.data()['name'];
        email = snap.data()['email'];
        phone = snap.data()['phone'];
        if (snap.data()['address'] != null) address = snap.data()['address'];

        if (snap.data()['regDate'] != null) {
          if (timestamp != null) timestamp = snap.data()['regData'];
        }
        if (snap.data()['image1'] != null) photo = snap.data()['image1'];

        if (snap.data()['image2'] != null) photo2 = snap.data()['image2'];

        if (snap.data()['summary'] != null) summary = snap.data()['summary'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uidNGO);
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
                        onTap: () {
                          Navigator.of(context).pop();
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
                    ngoName,
                    style: txtS(mc, 20, FontWeight.w600),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                sh(29),
                Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: b * 20),
                    width: b * 144,
                    height: h * 177,
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
                          width: b * 144,
                          height: h * 138,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(photo),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(b * 6),
                          ),
                        ),
                        sh(5),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Working Since',
                                style: txtS(textColor, 12, FontWeight.w400),
                              ),
                              Text(
                                regDate == 'NA'
                                    ? regDate
                                    : regDate.substring(0, 10),
                                style: txtS(textColor, 12, FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: b * 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: b * 170,
                        child: Text(
                          ngoName,
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
                            height: h * 30,
                            decoration: BoxDecoration(
                              color: mc,
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            child: Container(
                              height: h * 18,
                              width: b * 18,
                              child: SvgPicture.asset(
                                'images/rest.svg',
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
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
                sh(40),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: b * 20),
                  height: h * 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: Offset(0, 6),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(photo2),
                      fit: BoxFit.contain,
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
                        summary,
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
                                "mailto:$email?subject=Regarding Ngo Information&body=Can I get information regarding your employees");
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
                                  email,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtS(textColor, 13, FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onTap: () {
                            launchUrl("tel:$phone");
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
                                  phone,
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
                              address,
                              style: txtS(textColor, 13, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
