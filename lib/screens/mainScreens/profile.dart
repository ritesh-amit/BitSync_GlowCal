import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gur/dialogboxes/dialogBoxRequest.dart';
import 'package:gur/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences preferences;

  TextEditingController addressController = TextEditingController();
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController newConfirmPwdController = TextEditingController();

  bool isEmail = false;
  bool isPass = false;
  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isName = false;
  bool isPhone = false;
  bool isAddress = false;
  bool isComp = false;
  bool isSuggest = false;
  bool isMission = false;
  bool isAbout = false;
  bool isLogOut = false;
  bool isShare = false;
  bool isVersion = false;
  String userName = "";
  String userPhone = "";
  String address = "";
  String email = "";

  loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString("currentUserName");
      email = preferences.getString("currentUserEmail");

      if (preferences.containsKey("currentUserPhone")) {
        userPhone = preferences.getString("currentUserPhone");
      } else {
        userPhone = "Not Provided";
      }

      if (preferences.containsKey('currentUserAddress'))
        address = preferences.getString('currentUserAddress');
      else
        address = "Not Provided";
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
    //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: DrawerCode(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 15 / 896),
                  Row(
                    children: [
                      SizedBox(width: SizeConfig.screenWidth * 32 / 414),
                      Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Container(
                              height: SizeConfig.screenHeight * 35 / 896,
                              width: SizeConfig.screenWidth * 35 / 414,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: mc,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenWidth * 8 / 414),
                              ),
                              child: Icon(
                                MdiIcons.sortVariant,
                                color: mc,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 105 / 414),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: mc,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.screenWidth * 20 / 414,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 25 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 17 / 414,
                      vertical: SizeConfig.screenHeight * 11 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xffb9b9b9),
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                color: rc,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 6 / 896),
                            Text(
                              userName,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 16 / 414,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 17 / 414,
                      vertical: SizeConfig.screenHeight * 11 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color(0xffb9b9b9),
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                color: rc,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 6 / 896),
                            Text(
                              userPhone,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 16 / 414,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 17 / 414,
                      vertical: SizeConfig.screenHeight * 11 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.mail,
                          color: !isEmail ? Color(0xffb9b9b9) : textColor,
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              !isEmail ? 'Email' : "Update Email",
                              style: TextStyle(
                                color: !isEmail ? rc : textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 6 / 896),
                            !isEmail
                                ? Text(
                                    email,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          SizeConfig.screenWidth * 14 / 414,
                                    ),
                                  )
                                : Text(
                                    'Email',
                                    style: TextStyle(
                                      color: rc,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          SizeConfig.screenWidth * 14 / 414,
                                    ),
                                  ),
                            isEmail
                                ? Container(
                                    width: SizeConfig.screenWidth * 250 / 414,
                                    child: TextField(
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 414,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        hintText: 'Your Email ID',
                                        hintStyle: TextStyle(
                                          color: textColor,
                                          fontSize:
                                              SizeConfig.screenWidth * 14 / 414,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: SizeConfig.screenHeight *
                                                9 /
                                                896),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                                height: SizeConfig.screenHeight * 11 / 896),
                            isEmail
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 160 / 414,
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.screenWidth * 17 / 414,
                                          vertical:
                                              SizeConfig.screenHeight * 7 / 896,
                                        ),
                                        width:
                                            SizeConfig.screenWidth * 90 / 414,
                                        decoration: BoxDecoration(
                                          color: mc,
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.screenWidth *
                                                  18 /
                                                  414),
                                        ),
                                        child: Row(children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig.screenWidth *
                                                  12 /
                                                  414,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: SizeConfig.screenWidth *
                                                18 /
                                                414,
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
                                  isEmail = !isEmail;
                                });
                              },
                              child: Icon(
                                Icons.edit,
                                color: Color(0xffb9b9b9),
                                size: SizeConfig.screenWidth * 22 / 414,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 17 / 414,
                      vertical: SizeConfig.screenHeight * 11 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock,
                          color: !isPass ? Color(0xffb9b9b9) : textColor,
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              !isPass ? 'Password' : "Update Password",
                              style: TextStyle(
                                color: !isPass ? rc : textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 6 / 896),
                            !isPass
                                ? Text(
                                    '**************',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          SizeConfig.screenWidth * 14 / 414,
                                    ),
                                  )
                                : Text(
                                    'Old Password',
                                    style: TextStyle(
                                      color: rc,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          SizeConfig.screenWidth * 14 / 414,
                                    ),
                                  ),
                            isPass
                                ? Container(
                                    width: SizeConfig.screenWidth * 250 / 414,
                                    child: TextFormField(
                                      controller: oldPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 414,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        hintText: 'Your Old Password',
                                        hintStyle: TextStyle(
                                          color: textColor,
                                          fontSize:
                                              SizeConfig.screenWidth * 14 / 414,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth:
                                              SizeConfig.screenWidth * 16 / 414,
                                          minHeight: SizeConfig.screenHeight *
                                              12 /
                                              896,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig.screenWidth *
                                                  15 /
                                                  414),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            },
                                            child: Icon(
                                              isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                              size: SizeConfig.screenWidth *
                                                  16 /
                                                  414,
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: SizeConfig.screenHeight *
                                                9 /
                                                896),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            isPass
                                ? SizedBox(
                                    height: SizeConfig.screenHeight * 10 / 896)
                                : SizedBox(),
                            isPass
                                ? Container(
                                    width: SizeConfig.screenWidth * 250 / 414,
                                    child: TextFormField(
                                      controller: newPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible2,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 414,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        hintText: 'New Password',
                                        hintStyle: TextStyle(
                                          color: textColor,
                                          fontSize:
                                              SizeConfig.screenWidth * 14 / 414,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth:
                                              SizeConfig.screenWidth * 16 / 414,
                                          minHeight: SizeConfig.screenHeight *
                                              12 /
                                              896,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig.screenWidth *
                                                  15 /
                                                  414),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isVisible2 = !isVisible2;
                                              });
                                            },
                                            child: Icon(
                                              isVisible2
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                              size: SizeConfig.screenWidth *
                                                  16 /
                                                  414,
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: SizeConfig.screenHeight *
                                                9 /
                                                896),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            isPass
                                ? SizedBox(
                                    height: SizeConfig.screenHeight * 10 / 896)
                                : SizedBox(),
                            isPass
                                ? Container(
                                    width: SizeConfig.screenWidth * 250 / 414,
                                    child: TextFormField(
                                      controller: newConfirmPwdController,
                                      obscuringCharacter: '*',
                                      obscureText: !isVisible3,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 414,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        hintText: 'Confirm New Password',
                                        hintStyle: TextStyle(
                                          color: textColor,
                                          fontSize:
                                              SizeConfig.screenWidth * 14 / 414,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth:
                                              SizeConfig.screenWidth * 16 / 414,
                                          minHeight: SizeConfig.screenHeight *
                                              12 /
                                              896,
                                        ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig.screenWidth *
                                                  15 /
                                                  414),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isVisible3 = !isVisible3;
                                              });
                                            },
                                            child: Icon(
                                              isVisible3
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                              size: SizeConfig.screenWidth *
                                                  16 /
                                                  414,
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: SizeConfig.screenHeight *
                                                9 /
                                                896),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                                height: SizeConfig.screenHeight * 11 / 896),
                            isPass
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 160 / 414,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (newPwdController.text ==
                                            newConfirmPwdController.text) {
                                          pwdChangeRequest(
                                              oldPwdController.text,
                                              newPwdController.text);
                                        } else {
                                          Toast.show(
                                              "Password Mismatch", context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                        }
                                        //dialogBoxRequest(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.screenWidth * 17 / 414,
                                          vertical:
                                              SizeConfig.screenHeight * 7 / 896,
                                        ),
                                        width:
                                            SizeConfig.screenWidth * 90 / 414,
                                        decoration: BoxDecoration(
                                          color: mc,
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.screenWidth *
                                                  18 /
                                                  414),
                                        ),
                                        child: Row(children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig.screenWidth *
                                                  12 /
                                                  414,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: SizeConfig.screenWidth *
                                                18 /
                                                414,
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
                              child: Icon(
                                Icons.edit,
                                color: Color(0xffb9b9b9),
                                size: SizeConfig.screenWidth * 22 / 414,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 17 / 414,
                      vertical: SizeConfig.screenHeight * 11 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xffb9b9b9),
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              !isAddress ? 'Address' : 'Change Adrdress',
                              style: TextStyle(
                                color: !isAddress ? rc : textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 6 / 896),
                            Container(
                              width: SizeConfig.screenWidth * 235 / 414,
                              child: Text(
                                !isAddress ? address : "Address",
                                style: TextStyle(
                                  color: !isAddress ? textColor : rc,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.screenWidth * 16 / 414,
                                ),
                              ),
                            ),
                            isAddress
                                ? Container(
                                    width: SizeConfig.screenWidth * 250 / 414,
                                    child: TextField(
                                      controller: addressController,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize:
                                            SizeConfig.screenWidth * 16 / 414,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: rc,
                                            width: SizeConfig.screenWidth *
                                                1 /
                                                414,
                                          ),
                                        ),
                                        hintText: 'Your Address',
                                        hintStyle: TextStyle(
                                          color: textColor,
                                          fontSize:
                                              SizeConfig.screenWidth * 14 / 414,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: SizeConfig.screenHeight *
                                                9 /
                                                896),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                                height: SizeConfig.screenHeight * 11 / 896),
                            isAddress
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 160 / 414,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        preferences.setString(
                                            'currentUserAddress',
                                            addressController.text.trim());
                                        setState(() {
                                          isAddress = !isAddress;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.screenWidth * 17 / 414,
                                          vertical:
                                              SizeConfig.screenHeight * 7 / 896,
                                        ),
                                        width:
                                            SizeConfig.screenWidth * 90 / 414,
                                        decoration: BoxDecoration(
                                          color: mc,
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.screenWidth *
                                                  18 /
                                                  414),
                                        ),
                                        child: Row(children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig.screenWidth *
                                                  12 /
                                                  414,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: SizeConfig.screenWidth *
                                                18 /
                                                414,
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
                              child: Icon(
                                Icons.edit,
                                color: Color(0xffb9b9b9),
                                size: SizeConfig.screenWidth * 22 / 414,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 15 / 414,
                      vertical: SizeConfig.screenHeight * 15 / 896,
                    ),
                    width: SizeConfig.screenWidth * 350 / 414,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffb9b9b9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 18 / 414),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xffb9b9b9),
                          size: SizeConfig.screenWidth * 18 / 414,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 10 / 414,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Verification',
                              style: TextStyle(
                                color: rc,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.screenWidth * 14 / 414,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 9 / 896),
                            Container(
                              width: SizeConfig.screenWidth * 235 / 414,
                              child: Text(
                                'Account Not Verified(click to request verification)',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.screenWidth * 16 / 414,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.screenHeight * 12 / 896),
                            Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 60 / 414,
                              ),
                              child: InkWell(
                                onTap: () {
                                  dialogBoxRequest(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.screenWidth * 17 / 414,
                                    vertical: SizeConfig.screenHeight * 7 / 896,
                                  ),
                                  width: SizeConfig.screenWidth * 215 / 414,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: mc,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.screenWidth * 18 / 414),
                                  ),
                                  child: Row(children: [
                                    Text(
                                      'Request for verification',
                                      style: TextStyle(
                                        color: mc,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.screenWidth * 12 / 414,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: mc,
                                      size: SizeConfig.screenWidth * 18 / 414,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 200 / 896),
                ],
              ),
            ),
          ),
        ));
  }

  pwdChangeRequest(String pwd, String newPwd) {
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
}
