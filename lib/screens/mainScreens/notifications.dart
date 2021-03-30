import 'package:flutter/material.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import 'package:gur/drawerPages/drawer.dart';
import 'package:gur/appBar.dart';

class Notifications extends StatelessWidget {
final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 412;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerCode(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Bar(scaffoldKey: _scaffoldKey, title: "Notifications"),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications_paused, color: mc, size: b * 110),
              Text(
                'Sorry!! No Notifications',
                style: txtS(mc, 26, FontWeight.w400),
              ),
            ],
          ),
          Spacer(),
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
