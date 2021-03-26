import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gur/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NgoProfile extends StatefulWidget {
  _NgoProfileState createState() => _NgoProfileState();
}

class _NgoProfileState extends State<NgoProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  TextEditingController addressController = TextEditingController();
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController newConfirmPwdController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController inChargeNameController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isEmail = false;
  bool isPass = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isName = false;
  bool isPhone = false;
  bool isNgoName = false;
  bool isAddress = false;
  bool isDes = false;
  bool isSumm = false;
  String ngoName = "NA";
  String userPhone = "NA";
  String address = "NA";
  bool suraj = false;
  String designation = "NA";
  String inChargeName = 'NA';
  String summary = 'NA';

  String email = "";
  bool getImage1 = false;
  bool getImage2 = false;
  bool getImage3 = false;
  bool getImage4 = false;
  bool isLocation = false;
  bool isImageUpload = false;
  bool isLocationUpload = false;
  bool isLocationLoading = false;
  int count = 0;

  File image1File, image2File, image3File, image4File;

  loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      ngoName = preferences.getString("currentUserName");
      count++;
      email = preferences.getString("currentUserEmail");
      count++;

      if (preferences.containsKey("currentUserPhone")) {
        userPhone = preferences.getString("currentUserPhone");
        count++;
      }

      if (preferences.containsKey('currentUserAddress')) {
        address = preferences.getString('currentUserAddress');
        count++;
      }

      if (preferences.containsKey('currentUserDesignation')) {
        designation = preferences.getString('currentUserDesignation');
        count++;
      }

      if (preferences.containsKey('currentInChargeName')) {
        count++;
        inChargeName = preferences.getString('currentInChargeName');
      }

      if (preferences.containsKey('isProfileImageUploaded')) {
        isImageUpload = preferences.getBool('isProfileImageUploaded');
        count++;
      }
      if (preferences.containsKey('currentUserSummary')) {
        count++;
        summary = preferences.getString('currentUserSummary');
      }

      if (preferences.containsKey('isLocationGot')) {
        isLocationUpload = preferences.getBool('isLocationGot');
        count++;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
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
                InkWell(
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
                ),
                Spacer(),
                Text(
                  'Profile',
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
          sh(23),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: b * 20),
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Group 23.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'NGO Name',
                            style: txtS(rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          Text(
                            ngoName,
                            style: txtS(textColor, 16, FontWeight.w500),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Message.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Email',
                            style: txtS(rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          Text(
                            email,
                            style: txtS(textColor, 16, FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Password.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            !isPass ? 'Password' : "Update Password",
                            style: txtS(
                                !isPass ? rc : textColor, 14, FontWeight.w500),
                          ),
                          sh(6),
                          !isPass
                              ? Text(
                                  '**************',
                                  style: txtS(textColor, 16, FontWeight.w500),
                                )
                              : Container(
                                  width: b * 270,
                                  child: TextFormField(
                                    controller: oldPwdController,
                                    obscuringCharacter: '*',
                                    obscureText: !isVisible,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                    decoration: deco('Your Old Password', 1),
                                  ),
                                ),
                          isPass ? sh(10) : SizedBox(),
                          isPass
                              ? Container(
                                  width: b * 270,
                                  child: TextFormField(
                                    controller: newPwdController,
                                    obscuringCharacter: '*',
                                    obscureText: !isVisible2,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                    decoration: deco('New Password', 2),
                                  ),
                                )
                              : SizedBox(),
                          isPass ? sh(10) : SizedBox(),
                          isPass
                              ? Container(
                                  width: b * 270,
                                  child: TextFormField(
                                    controller: newConfirmPwdController,
                                    obscuringCharacter: '*',
                                    obscureText: !isVisible3,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                    decoration: deco('Confirm New Password', 3),
                                  ),
                                )
                              : SizedBox(),
                          isPass
                              ? Padding(
                                  padding: EdgeInsets.only(left: b * 180),
                                  child: InkWell(
                                    onTap: () {
                                      if (newPwdController.text ==
                                          newConfirmPwdController.text) {
                                        pwdChangeRequest(oldPwdController.text,
                                            newPwdController.text);
                                      } else {
                                        Toast.show("Password Mismatch", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: h * 11),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: b * 17, vertical: h * 7),
                                      width: b * 90,
                                      decoration: BoxDecoration(
                                        color: mc,
                                        borderRadius:
                                            BorderRadius.circular(b * 18),
                                      ),
                                      child: Row(children: [
                                        Text(
                                          'Save',
                                          style: txtS(Colors.white, 12,
                                              FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: b * 18,
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isPass = !isPass;
                              });
                            },
                            child: ediB(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Call.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Number',
                            style: txtS(rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          Text(
                            userPhone,
                            style: txtS(textColor, 16, FontWeight.w500),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Profile.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            isName ? 'Change Name' : 'Person In-Charge',
                            style: txtS(
                                isName ? textColor : rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          isName
                              ? Container(
                                  width: b * 270,
                                  child: TextField(
                                    controller: inChargeNameController,
                                    style: txtS(textColor, 15, FontWeight.w500),
                                    decoration: dec('Name of In-Charge'),
                                  ),
                                )
                              : Text(
                                  inChargeName,
                                  style: txtS(textColor, 16, FontWeight.w500),
                                ),
                          isName
                              ? butt(
                                  field: 'inChargeName',
                                )
                              : SizedBox(),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isName = !isName;
                              });
                            },
                            child: ediB(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Group 23.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            isDes ? 'Change Designation' : 'Designation',
                            style: txtS(
                                isDes ? textColor : rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          isDes
                              ? Container(
                                  width: b * 270,
                                  child: TextField(
                                    style: txtS(textColor, 15, FontWeight.w500),
                                    controller: designationController,
                                    decoration:
                                        dec('Person-In-Charge Designation'),
                                  ),
                                )
                              : Text(
                                  designation,
                                  style: txtS(textColor, 16, FontWeight.w500),
                                ),
                          isDes ? butt(field: 'designation') : SizedBox(),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isDes = !isDes;
                              });
                            },
                            child: ediB(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Location.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            !isAddress ? 'Address' : 'Change Adrdress',
                            style: txtS(!isAddress ? rc : textColor, 14,
                                FontWeight.w500),
                          ),
                          sh(6),
                          !isAddress
                              ? Container(
                                  width: b * 235,
                                  child: Text(
                                    address,
                                    style: txtS(!isAddress ? textColor : rc, 16,
                                        FontWeight.w500),
                                  ),
                                )
                              : Container(
                                  width: b * 270,
                                  child: TextField(
                                    controller: addressController,
                                    style: txtS(textColor, 16, FontWeight.w500),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: rc,
                                          width: b,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: rc,
                                          width: b,
                                        ),
                                      ),
                                      hintText: 'Your Address',
                                      hintStyle:
                                          txtS(textColor, 14, FontWeight.w400),
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: h * 9),
                                    ),
                                  ),
                                ),
                          isAddress
                              ? Padding(
                                  padding: EdgeInsets.only(left: b * 180),
                                  child: InkWell(
                                    onTap: () {
                                      userDetailChange('address');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: h * 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: b * 17, vertical: h * 7),
                                      width: b * 90,
                                      decoration: BoxDecoration(
                                        color: mc,
                                        borderRadius:
                                            BorderRadius.circular(b * 18),
                                      ),
                                      child: Row(children: [
                                        Text(
                                          'Save',
                                          style: txtS(Colors.white, 12,
                                              FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: b * 18,
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAddress = !isAddress;
                              });
                            },
                            child: ediB(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(9),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: b * 17, vertical: h * 11),
                  width: b * 375,
                  decoration: bord(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ico('images/Chart.svg'),
                      SizedBox(width: b * 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            isSumm ? 'Brief Summary' : 'Edit Summary',
                            style: txtS(
                                isName ? textColor : rc, 14, FontWeight.w500),
                          ),
                          sh(6),
                          isSumm
                              ? Container(
                                  width: b * 270,
                                  child: TextField(
                                    controller: summaryController,
                                    style: txtS(textColor, 15, FontWeight.w500),
                                    decoration: dec('Summary'),
                                  ),
                                )
                              : Text(
                                  summary,
                                  style: txtS(textColor, 16, FontWeight.w500),
                                ),
                          isSumm ? butt(field: 'summary') : SizedBox(),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSumm = !isSumm;
                              });
                            },
                            child: ediB(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sh(10),
                isImageUpload
                    ? sh(1)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NGO Pics",
                            style: txtS(rc, 16, FontWeight.w700),
                          ),
                          sh(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getImageCont(getImage1, 1),
                              getImageCont(getImage2, 2),
                              getImageCont(getImage3, 3),
                              getImageCont(getImage4, 4),
                            ],
                          ),
                          sh(20),
                          MaterialButton(
                            height: h * 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            color: !isImageUpload ? mc : Color(0xff28797c),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              uploadImageAndToDB();
                            },
                            child: Container(
                              color: !isImageUpload ? mc : Color(0xff28797c),
                              child: Text(
                                !isImageUpload ? "Upload Images" : "Done",
                                style: txtS(Colors.white, 10, FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                sh(20),
                isLocationUpload
                    ? SizedBox()
                    : Row(
                        children: [
                          Text(
                            "Record NGO\'s Geolocation",
                            style: txtS(textColor, 16, FontWeight.w700),
                          ),
                          Spacer(),
                          MaterialButton(
                            height: h * 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(b * 6),
                            ),
                            color: !isLocation ? mc : Color(0xff28797c),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              setState(() {
                                isLocationLoading = true;
                              });
                              currentLocation();
                            },
                            child: Container(
                              color: !isLocation ? mc : Color(0xff28797c),
                              child: isLocationLoading
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      !isLocation ? "Get location" : "Done",
                                      style: txtS(
                                          Colors.white, 10, FontWeight.w500),
                                    ),
                            ),
                          ),
                        ],
                      ),
                sh(25),
                Container(
                  decoration: bord(),
                  height: h * 63,
                  width: b * 375,
                  child: Row(children: [
                    SizedBox(width: b * 1),
                    Container(
                      alignment: Alignment.center,
                      height: h * 59,
                      width: b * 375 * (count / 9),
                      decoration: BoxDecoration(
                        color: Color(0xff28797c),
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth / 414 * 8),
                      ),
                      child: Text(
                        ((count / 9) * 100).floor().toString() + "% Completed",
                        style: txtS(gc, 16, FontWeight.w500),
                      ),
                    ),
                  ]),
                ),
                sh(200),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  InkWell getImageCont(bool isImage, int imageCode) {
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return InkWell(
      splashColor: mc,
      onTap: () {
        pickImage(imageCode);
      },
      child: isImage
          ? Container(
              height: h * 80,
              width: b * 80,
              decoration: BoxDecoration(
                border: Border.all(color: rc),
                borderRadius: BorderRadius.circular(b * 5),
              ),
              child: imageCode == 1
                  ? Image.file(image1File)
                  : imageCode == 2
                      ? Image.file(image2File)
                      : imageCode == 3
                          ? Image.file(image3File)
                          : Image.file(image4File),
            )
          : Container(
              height: h * 80,
              width: b * 80,
              decoration: BoxDecoration(
                border: Border.all(color: rc),
                borderRadius: BorderRadius.circular(b * 5),
              ),
              child: Icon(Icons.add, color: rc),
            ),
    );
  }

  Container ico(String qwerty) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Container(
      height: h * 20,
      width: b * 20,
      child: SvgPicture.asset(
        qwerty,
        allowDrawingOutsideViewBox: true,
        width: h * 20,
        height: b * 20,
        color: Color(0xffb9b9b9),
      ),
    );
  }

  Padding butt({String field}) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth / 414 * 180,
          top: SizeConfig.screenHeight / 896 * 10),
      child: InkWell(
        onTap: () {
          userDetailChange(field);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth / 414 * 17,
            vertical: SizeConfig.screenHeight / 896 * 7,
          ),
          width: SizeConfig.screenWidth / 414 * 90,
          decoration: BoxDecoration(
            color: mc,
            borderRadius:
                BorderRadius.circular(SizeConfig.screenWidth / 414 * 18),
          ),
          child: Row(children: [
            Text(
              'Save',
              style: txtS(Colors.white, 12, FontWeight.w400),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: SizeConfig.screenWidth / 414 * 18,
            ),
          ]),
        ),
      ),
    );
  }

  Container ediB() {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Container(
      height: h * 20,
      width: b * 20,
      child: SvgPicture.asset(
        'images/edit.svg',
        allowDrawingOutsideViewBox: true,
        width: h * 20,
        height: b * 20,
      ),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  UnderlineInputBorder under() {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: rc,
        width: SizeConfig.screenWidth * 1 / 414,
      ),
    );
  }

  InputDecoration deco(String hi, int isV) {
    return InputDecoration(
      enabledBorder: under(),
      focusedBorder: under(),
      hintText: hi,
      hintStyle: txtS(textColor, 14, FontWeight.w400),
      suffixIconConstraints: BoxConstraints(
        minWidth: SizeConfig.screenWidth / 414 * 16,
        minHeight: SizeConfig.screenHeight / 896 * 12,
      ),
      suffixIcon: Padding(
        padding:
            EdgeInsets.only(right: SizeConfig.screenWidth / 414 * 15 / 414),
        child: InkWell(
          onTap: () {
            setState(() {
              if (isV == 1) {
                isVisible = !isVisible;
                suraj = isVisible;
              } else if (isV == 2) {
                isVisible2 = !isVisible2;
                suraj = isVisible2;
              } else if (isV == 3) {
                isVisible3 = !isVisible3;
                suraj = isVisible3;
              }

              print(isVisible);
              print(isVisible2);
              print(isVisible3);
              print(suraj);
            });
          },
          child: Icon(
            suraj ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
            size: SizeConfig.screenWidth / 414 * 16,
          ),
        ),
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight / 896 * 9),
    );
  }

  InputDecoration dec(String hin) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: rc,
          width: SizeConfig.screenWidth / 414 * 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: rc,
          width: SizeConfig.screenWidth * 1 / 414,
        ),
      ),
      hintText: hin,
      hintStyle: TextStyle(
        color: textColor,
        fontSize: SizeConfig.screenWidth / 414 * 14,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 9 / 896),
    );
  }

  BoxDecoration bord() {
    return BoxDecoration(
      border: Border.all(
        color: rc,
        width: SizeConfig.screenWidth * 1 / 414,
      ),
      borderRadius: BorderRadius.circular(SizeConfig.screenWidth / 414 * 8),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 896);
  }

  void pwdChangeRequest(String pwd, String newPwd) {
    FirebaseAuth auth = FirebaseAuth.instance;

    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pwd);

    auth.currentUser.reauthenticateWithCredential(credential).catchError((e) {
      print("Error is: $e");
    }).then((value) {
      auth.currentUser.updatePassword(newPwd).catchError((e) {
        print(e);
      }).timeout(Duration(seconds: 10), onTimeout: () {
        Toast.show("Server Error", context, duration: Toast.LENGTH_LONG);
      }).then((value) {
        Toast.show("Password Changed Succesfully", context,
            duration: Toast.LENGTH_LONG);
        setState(() {
          isPass = !isPass;
        });
      });
    });
  }

  userDetailChange(String field) async {
    //print("Value Changed : $data");
    String data = 'NA';

    setState(() {
      if (field == 'summary') {
        data = summaryController.text.trim();
      } else if (field == 'address') {
        data = addressController.text.trim();
      } else if (field == 'designation') {
        data = designationController.text.trim();
      } else if (field == 'inChargeName') {
        data = inChargeNameController.text.trim();
      }
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String uid = pref.getString('currentUserUID');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({field: data}).then((value) {
      setState(() {
        if (field == 'address') {
          pref.setString('currentUserAddress', data);
          address = data;
          isAddress = false;
        } else if (field == 'designation') {
          pref.setString('currentUserDesignation', data);
          designation = data;
          isDes = false;
        } else if (field == 'summary') {
          pref.setString('currentUserSummary', data);
          summary = data;
          isSumm = false;
        } else if (field == 'inChargeName') {
          pref.setString('currentInChargeName', data);
          inChargeName = data;
          isName = false;
        }
      });
    });
  }

  pickImage(int imageCode) async {
    var picker = await ImagePicker().getImage(source: ImageSource.gallery);

    File selectedImage = File(picker.path);
    setState(() {
      if (imageCode == 1) {
        image1File = selectedImage;
        getImage1 = true;
      } else if (imageCode == 2) {
        image2File = selectedImage;
        getImage2 = true;
      } else if (imageCode == 3) {
        image3File = selectedImage;
        getImage3 = true;
      } else {
        image4File = selectedImage;
        getImage4 = true;
      }
    });
  }

  uploadImageAndToDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('currentUserUID');

    if (image1File == null &&
        image2File == null &&
        image3File == null &&
        image4File == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Upload all four images"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ));
    } else {
      await FirebaseStorage.instance
          .ref()
          .child('ngoImages')
          .child(uid)
          .child('1')
          .putFile(image1File);

      await FirebaseStorage.instance
          .ref()
          .child('ngoImages')
          .child(uid)
          .child('2')
          .putFile(image2File);

      await FirebaseStorage.instance
          .ref()
          .child('ngoImages')
          .child(uid)
          .child('3')
          .putFile(image3File);

      await FirebaseStorage.instance
          .ref()
          .child('ngoImages')
          .child(uid)
          .child('4')
          .putFile(image4File)
          .then((snapshot) {
        setState(() {
          isImageUpload = true;
        });
      });

      String image1URL = await getImageLink('1', uid);
      String image2URL = await getImageLink('2', uid);
      String image3URL = await getImageLink('3', uid);
      String image4URL = await getImageLink('4', uid);

      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'image1': image1URL,
        'image2': image2URL,
        'image3': image3URL,
        'image4': image4URL
      }).then((value) {
        setState(() {
          count++;
          checkCount();
          preferences.setBool('isProfileImageUploaded', true);
          preferences.setString('profileImageURL', image1URL);
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Images Uploaded Successfully"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    }
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

  currentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionStatus;
    serviceEnabled = await location.serviceEnabled();
    bool permissionsOK;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled)
        permissionsOK = true;
      else
        permissionsOK = false;
    } else
      permissionsOK = true;

    permissionStatus = await location.hasPermission();
    if (permissionStatus == loc.PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus == loc.PermissionStatus.denied ||
          permissionStatus == loc.PermissionStatus.deniedForever) {
        permissionsOK = false;
        Toast.show("Permission Required", context);
      } else
        permissionsOK = true;
    } else if (permissionStatus == loc.PermissionStatus.deniedForever)
      Toast.show("Permission Required", context);
    else
      permissionsOK = true;

    if (permissionsOK) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((position) {
        double latitude = position.latitude;
        double longitude = position.longitude;

        FirebaseFirestore.instance
            .collection('users')
            .doc(preferences.getString('currentUserUID'))
            .update({'lon': longitude, 'lat': latitude}).then((value) {
          setState(() {
            isLocationLoading = !isLocationLoading;
            isLocation = !isLocation;
          });

          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              isLocationUpload = true;
              count++;
            });
          });

          preferences.setBool('isLocationGot', true);
          checkCount();
        });
      });
    } else
      Toast.show("Insufficient Permission", context);
  }

  checkCount() {
    if (count == 9) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'isVerified': true}).then((value) {
        preferences.setBool('isVerified', true);
      });
    }
  }
}
