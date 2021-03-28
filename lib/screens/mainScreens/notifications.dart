import 'package:flutter/material.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gur/drawerPages/drawer.dart';
import 'package:gur/screens/chatSection/messageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notifications extends StatefulWidget {
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  'Notifications',
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
                    ),
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
              itemCount: 5,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: h * 60,
                      padding: EdgeInsets.symmetric(
                          horizontal: b * 20, vertical: h * 10),
                      margin: EdgeInsets.only(top: h * 12, bottom: h * 12),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.13),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('images/ill1.png'),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(b * 12),
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
