import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gur/screens/chatSection/chatScreen.dart';
import 'package:gur/screens/chatSection/messageScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/drawerPages/drawer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.data);
  print("Handling a background message: ${message.messageId}");
}

class NgoHome extends StatefulWidget {
  _NgoHomeState createState() => _NgoHomeState();
}

class _NgoHomeState extends State<NgoHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController aboutController = TextEditingController();
  bool isAbout = false;
  String uid = '';
  String ngoName = 'NA';
  String email = "NA";
  String phone = 'NA';
  String address = 'NA';
  String photo2 = 'NA';
  String headImageURL = 'NA';
  String regDate = "NA";
  String summary = 'NA';
  bool isVerified = false;
  int packagesNo = 0;

  File image1File, image2File, image3File, image4File;
  bool getImage1 = false;
  bool getImage2 = false;
  bool getImage3 = false;
  bool getImage4 = false;
  @override
  void initState() {
    super.initState();
    fcmInit(context);

    getDataFromLocalStorage();
  }

  fcmInit(ctx) async {
    print("Inside FCM init Function");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      addDonotToDB(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published');

      addDonotToDB(message);
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  addDonotToDB(RemoteMessage message) async {
    print("Donor UID: ${message.data['donorUid']}");
    print("NGO UID: ${message.data['uid']}");
    String ngoName = "";
    FirebaseFirestore.instance
        .collection('users')
        .doc(message.data['uid'])
        .snapshots()
        .listen((snap) {
      ngoName = snap.data()['name'];
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(message.data['donorUid'])
        .snapshots()
        .listen((snap) {
      String donorName = snap.data()['name'];

      FirebaseFirestore.instance
          .collection('donorChats')
          .doc('lists')
          .collection(message.data['uid'])
          .doc(message.data['donorUid'])
          .set({
        'uid': message.data['donorUid'],
        'name': donorName,
        'isAccept': false
      }).then((value) {
        uid = FirebaseAuth.instance.currentUser.uid;

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatScreen(
              receiverUid: message.data['donorUid'],
              senderUID: message.data['uid']);
        }));
      });

      FirebaseFirestore.instance
          .collection('donorChats')
          .doc('lists')
          .collection(message.data['donorUid'])
          .doc(message.data['uid'])
          .set(
              {'uid': message.data['uid'], 'name': ngoName, 'isAccept': false});
    });
  }

  getDataFromLocalStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      ngoName = preferences.getString('currentUserName');
      email = preferences.getString('currentUserEmail');
      phone = preferences.getString('currentUserPhone');
      if (preferences.containsKey('profileImageURL'))
        headImageURL = preferences.getString('profileImageURL');
      if (preferences.containsKey('baseImageUrl'))
        photo2 = preferences.getString('baseImageUrl');
      if (preferences.containsKey('currentUserAddress'))
        address = preferences.getString('currentUserAddress');
      if (preferences.containsKey('currentUserSummary'))
        summary = preferences.getString('currentUserSummary');

      if (preferences.containsKey('isVerified'))
        isVerified = preferences.getBool('isVerified');
      if (preferences.containsKey('currentUserRegDate'))
        regDate = preferences.getString('currentUserRegDate');

      if (preferences.containsKey('packagesDelivered'))
        packagesNo = preferences.getInt('packagesDelivered');
    });
  }

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
                  onTap: () {
                    String uid = FirebaseAuth.instance.currentUser.uid;
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MessageScreen(uid: uid);
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
                        /* image: DecorationImage(
                            image: headImageURL == "NA"
                                ? AssetImage('images/headNoImage.png')
                                : NetworkImage(headImageURL),
                            fit: headImageURL == "NA"
                                ? BoxFit.contain
                                : BoxFit.cover), */
                        borderRadius: BorderRadius.circular(b * 12),
                      ),
                      child: headImageURL == 'NA'
                          ? Image.asset(
                              'images/headNoImage.png',
                              fit: BoxFit.contain,
                            )
                          : CachedNetworkImage(
                              imageUrl: headImageURL,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(b * 12),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      right: b * 30,
                      bottom: h * 7,
                      child: InkWell(
                        onTap: () {
                          pickImage(1);
                        },
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
                          child: SvgPicture.asset(
                            'images/rest.svg',
                            allowDrawingOutsideViewBox: true,
                            width: h * 20,
                            height: b * 20,
                          ),
                        ),
                        SizedBox(width: b * 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              packagesNo.toString(),
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
                    isVerified
                        ? Row(
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
                          )
                        : SizedBox()
                  ],
                ),
              ]),
              sh(30),
              Stack(
                children: [
                  Container(
                    /* child: Image.network(
                      photo2,
                      fit: BoxFit.cover,
                    ),*/
                    margin: EdgeInsets.symmetric(horizontal: b * 20),
                    height: h * 147,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 24,
                          spreadRadius: -7,
                          offset: Offset(0, 6),
                        ),
                      ],
                      image: DecorationImage(
                        image: photo2 == 'NA'
                            ? AssetImage('images/baseNoImage.png')
                            : NetworkImage(photo2), // NetworkImage(photo2),
                        fit: BoxFit.cover,
                      ),
                      color: gc,
                      borderRadius: BorderRadius.circular(b * 6),
                    ),
                  ),
                  Positioned(
                    right: b * 30,
                    bottom: h * 7,
                    child: InkWell(
                      onTap: () {
                        pickImage(2);
                      },
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
                      ],
                    ),
                    sh(10),
                    Text(
                      summary,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: txtS(Color(0xff828282), 14, FontWeight.w500),
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
                              email,
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
                              phone,
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
                                  address,
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
                                  regDate == 'NA'
                                      ? regDate
                                      : regDate.substring(0, 10),
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

  pickImage(int imageCode) async {
    var picker = await ImagePicker().getImage(source: ImageSource.gallery);

    File selectedImage = File(picker.path);
    setState(() {
      if (imageCode == 1) {
        image1File = selectedImage;
        uploadImageAndToDB(1);
      } else if (imageCode == 2) {
        image2File = selectedImage;
        uploadImageAndToDB(2);
      }
    });
  }

  uploadImageAndToDB(int code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('currentUserUID');
    String fileCode;
    if (code == 1)
      fileCode = '1';
    else if (code == 2) fileCode = '2';

    await FirebaseStorage.instance
        .ref()
        .child('ngoImages')
        .child(uid)
        .child(fileCode)
        .putFile(image1File)
        .then((task) async {
      String imageURL = await getImageLink(fileCode, uid);

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'image' + fileCode: imageURL}).then((value) {
        if (code == 1)
          preferences.setString('profileImageURL', imageURL);
        else if (code == 2) preferences.setString('baseImageUrl', imageURL);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Images Uploaded Successfully"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Encountered'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  Future<String> getImageLink(String code, String uid) async {
    String url = await FirebaseStorage.instance
        .ref()
        .child('ngoImages')
        .child(uid)
        .child(code)
        .getDownloadURL();

    return url;
  }
}
