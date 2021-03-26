import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gur/dialogboxes/dialogBoxSearch.dart';
import 'package:gur/dialogboxes/dialogBoxDonate.dart';
import 'package:gur/drawer.dart';
import 'package:gur/screens/chatSection/messageScreen.dart';
import 'package:gur/screens/mainScreens/aboutNgo.dart';
import 'package:location/location.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List mainImageList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadMainImageList() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'ngo')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;
      mainImageList.clear();
      setState(() {
        for (var i in documentSnapshot) {
          mainImageList
              .add({'imageURL': i.data()['image1'], 'uid': i.data()['uid']});

          //mainImageList.add(i.data()['image1']);
        }
      });
    });

    //return mainImageList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    bool isSearch = false;
    List images = [
      'images/2.png',
      'images/3.png',
      'images/4.png',
      'images/5.png',
      'images/6.png',
      'images/7.png',
      'images/8.png',
      'images/9.png',
      'images/2.png',
      'images/3.png',
      'images/4.png',
      'images/5.png',
      'images/6.png',
      'images/7.png',
      'images/8.png',
      'images/9.png',
    ];

    List headingItems = [
      'User Summary',
      'User Summary',
      'Global Summary',
      'Global Summary'
    ];

    List midItems = [
      'Amount Donated',
      'No. of times donated',
      'Total amount donated',
      'Total donations'
    ];
    List summaryItems = ['140 Kg', '7', '2000 Kg', '1900'];
    List quoteItems = [
      'Remember that the happiest people are not those getting more, but those giving more.',
      'Since you get more joy out of giving joy to others, you should put a good deal of thought into the happiness that you are able to give.',
      'We must give more in order to get more. It is the generous giving of ourselves that produces the generous harvest.',
      'We make a living by what we get. We make a life by what we give.',
      'No one is useless in this world who lightens the burdens of another.',
      'It is every man’s obligation to put back into the world at least the equivalent of what he takes out of it.',
      'The meaning of life is to find your gift. The purpose of life is to give it away.',
      'I have found that among its other benefits, giving liberates the soul of the giver.'
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCode(),
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
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MessageScreen(
                            uid: FirebaseAuth.instance.currentUser.uid);
                      }));
                    },
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
                InkWell(
                  onTap: () {
                    setState(() {
                      dialogBoxSearch(context);
                      isSearch = !isSearch;
                      print('serach');
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: b * 20),
                    padding: EdgeInsets.symmetric(vertical: h * 12),
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(b * 49),
                    ),
                    child: Image.asset('images/search.png', width: b * 133),
                  ),
                ),
                sh(20),
                Container(
                  width: b * 375,
                  height: h * 140,
                  margin: EdgeInsets.only(left: b * 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: images.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () {
                          return dialogBoxCoupon(context);
                        },
                        child: Container(
                          width: b * 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(b * 6),
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                sh(24),
                Container(
                  width: b * 375,
                  height: h * 90,
                  padding: EdgeInsets.only(left: b * 13.5),
                  color: Color(0xfffff2e1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: b * 6.5, vertical: h * 11),
                        padding: EdgeInsets.symmetric(horizontal: b * 10),
                        width: b * 168,
                        height: h * 122,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xffffddb1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(b * 6),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              headingItems[index],
                              style: txtS(textColor, 14, FontWeight.w600),
                            ),
                            Text(
                              midItems[index],
                              style:
                                  txtS(Color(0xff28797c), 10, FontWeight.w400),
                            ),
                            Text(
                              summaryItems[index],
                              style: txtS(mc, 14, FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                sh(20),
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    height: h * 130,
                    autoPlay: true,
                  ),
                  items: quoteItems.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: h * 10),
                          padding: EdgeInsets.symmetric(horizontal: b * 40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Text(
                            '$i',
                            textAlign: TextAlign.center,
                            style: txtS(textColor, 14, FontWeight.w500),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                sh(10),
                Padding(
                  padding: EdgeInsets.only(left: b * 20),
                  child: Text(
                    'NGOs Near Me',
                    style: txtS(textColor, 16, FontWeight.w600),
                  ),
                ),
                sh(10),
                FutureBuilder(
                    future: loadMainImageList(),
                    builder: (context, snapshot) {
                      return Container(
                        width: b * 375,
                        height: h * 102,
                        margin: EdgeInsets.only(left: b * 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: mainImageList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AboutNgo(
                                    uidNGO: mainImageList[index]['uid'],
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: b * 13),
                                width: b * 102,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(b * 17),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: mainImageList[index]['imageURL'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                sh(20),
                InkWell(
                  onTap: () {
                    dialogBoxDonate(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: b * 20, right: b * 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: h * 15,
                    ),
                    width: b * 374,
                    decoration: BoxDecoration(
                      color: mc,
                      boxShadow: [
                        BoxShadow(
                          color: mc.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(b * 46),
                    ),
                    child: Text(
                      'Donate',
                      style: txtS(Colors.white, 16, FontWeight.w700),
                    ),
                  ),
                ),
                sh(140),
              ]),
            ),
          ]),
        ]),
      ),
    );
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: Color(0xffb9b9b9),
        fontSize: SizeConfig.screenWidth * 14 / 412,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 11 / 896),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  void dialogBoxCoupon(BuildContext context) {
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
                        'You want to redeem this Coupon?',
                        textAlign: TextAlign.center,
                        style: txtS(textColor, 20, FontWeight.w600),
                      ),
                    ),
                    sh(30),
                    Row(
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
                              style:
                                  txtS(Color(0xff28797c), 16, FontWeight.w600),
                            ),
                          ),
                        ),
                        MaterialButton(
                          elevation: 5,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
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
                              style: txtS(Colors.white, 16, FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 400),
    );
  }
}
