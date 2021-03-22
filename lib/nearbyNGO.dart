import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gur/models/ngo.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class NearbyNGO extends StatefulWidget {
  final double userLat;
  final double userLong;

  NearbyNGO({this.userLat, this.userLong});
  @override
  _NearbyNGOState createState() => _NearbyNGOState();
}

class _NearbyNGOState extends State<NearbyNGO> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadList();
  }

  List nearbyNGOList = [];

  loadList() async {
    FirebaseFirestore.instance
        .collection('ngo')
        .where('isVarified', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> completeList = snapshot.docs;

      for (var i in completeList) {
        double lat = i.data()['lat'];
        double lon = i.data()['lon'];

        int distance = (Geolocator.distanceBetween(
                    lat, lon, widget.userLat, widget.userLong) /
                1000)
            .ceil();

        NGO tempNGO = NGO(
            distance: distance,
            name: i.data()['name'],
            photoUrl: i.data()['photoURL']);

        nearbyNGOList.add(tempNGO);
      }

      setState(() {
        nearbyNGOList.sort((a, b) {
          return a.distance.compareTo(b.distance);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(children: [
            sh(30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: b * 20),
              padding:
                  EdgeInsets.symmetric(horizontal: b * 10, vertical: h * 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(b * 13),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: nearbyNGOList.length,
                itemBuilder: (context, index) => nearbyNGOList.length == 0
                    ? CircularProgressIndicator()
                    : Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: index == 0 ? h * 0 : h * 12,
                                  bottom: h * 12),
                              height: h * 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(b * 20),
                                color: Color(0xffff1f1f1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: h * 97,
                                    width: b * 97,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(b * 13),
                                      color: Color(0xff785758),
                                    ),
                                  ),
                                  SizedBox(width: b * 15),
                                  Container(
                                    width: b * 230,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        sh(7),
                                        Container(
                                          width: b * 144,
                                          child: Text(
                                            nearbyNGOList[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: txtS(
                                                textColor, 20, FontWeight.w600),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: b * 16,
                                              height: h * 16,
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        b * 4),
                                              ),
                                              child: Icon(Icons.food_bank,
                                                  color: Colors.white,
                                                  size: b * 10),
                                            ),
                                            SizedBox(width: b * 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  nearbyNGOList[index]
                                                          .distance
                                                          .toString() +
                                                      " km",
                                                  style: txtS(textColor, 12,
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  'Packages Delivered',
                                                  style: txtS(
                                                      rc, 10, FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: textColor,
        fontSize: SizeConfig.screenWidth * 18 / 412,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 15 / 896),
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
}
