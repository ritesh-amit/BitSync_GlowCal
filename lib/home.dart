import 'package:flutter/material.dart';
import 'package:gur/dialogBoxDonate.dart';
import 'package:gur/drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      drawer: DrawerCode(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 32 / 414),
          child: ListView(children: [
            SizedBox(height: SizeConfig.screenHeight * 15 / 896),
            Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
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
                Spacer(),
                Text(
                  'Home',
                  style: TextStyle(
                    color: mc,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.screenWidth * 20 / 414,
                  ),
                ),
                Spacer(),
                Icon(
                  MdiIcons.message,
                  color: mc,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 26 / 896),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth * 350 / 414,
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 15 / 896,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 24,
                      spreadRadius: -8,
                      offset: Offset(0, 6),
                    ),
                  ],
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 43 / 414),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: textColor),
                    Text(
                      'Search NGOs',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 18 / 414,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 25 / 896),
            Row(children: [
              Container(
                width: SizeConfig.screenWidth * 160 / 414,
                height: SizeConfig.screenHeight * 180 / 896,
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
              SizedBox(width: SizeConfig.screenWidth * 30 / 414),
              Container(
                width: SizeConfig.screenWidth * 160 / 414,
                height: SizeConfig.screenHeight * 180 / 896,
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
            ]),
            SizedBox(height: SizeConfig.screenHeight * 27 / 896),
            Container(
              width: SizeConfig.screenWidth * 350 / 414,
              height: SizeConfig.screenHeight * 150 / 896,
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
            SizedBox(height: SizeConfig.screenHeight * 19 / 896),
            Text(
              'NGOs Near Me',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.screenWidth * 16 / 414,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 10 / 896),
            Container(
              width: SizeConfig.screenWidth * 350 / 414,
              height: SizeConfig.screenHeight * 120 / 896,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 15,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 9 / 414,
                      vertical: SizeConfig.screenHeight * 9 / 896,
                    ),
                    width: SizeConfig.screenWidth * 102 / 414,
                    height: SizeConfig.screenHeight * 102 / 896,
                    decoration: BoxDecoration(
                      color: gc,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        SizeConfig.screenWidth * 16 / 414,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 28 / 896),
            InkWell(
              onTap: () {
                dialogBoxDonate(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 17 / 414,
                  vertical: SizeConfig.screenHeight * 15 / 896,
                ),
                width: SizeConfig.screenWidth * 350 / 414,
                decoration: BoxDecoration(
                  color: mc,
                  boxShadow: [
                    BoxShadow(
                      color: mc.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenWidth * 46 / 414),
                ),
                child: Text(
                  'Donate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.screenWidth * 16 / 414,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
