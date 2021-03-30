import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gur/dialogboxes/donateDoneDialog.dart';
import 'package:gur/models/foodPacket.dart';
import 'package:gur/models/ngo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NearbyNGO extends StatefulWidget {
  final FoodPacket foodPacket;

  NearbyNGO(this.foodPacket);
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

  List<NGO> nearbyNGOList = [];

  loadList() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'ngo')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> completeList = snapshot.docs;
      nearbyNGOList.clear();

      for (var i in completeList) {
        double lat = i.data()['lat'];
        double lon = i.data()['lon'];
        bool isVerified = false;
        int packagesNo = 0;

        if (i.data()['isVerified'] != null && i.data()['isVerified'] == true) {
          isVerified = i.data()['isVerified'];

          if (i.data()['packagesDelivered'] != null)
            packagesNo = i.data()['packagesDelivered'];

          int distance = (Geolocator.distanceBetween(lat, lon,
                      widget.foodPacket.latitude, widget.foodPacket.longitude) /
                  1000)
              .ceil();

          NGO tempNGO = NGO(
              distance: distance,
              name: i.data()['name'],
              photoUrl: i.data()['image1'],
              uid: i.data()['uid'],
              isVerified: isVerified,
              packageNo: packagesNo);

          nearbyNGOList.add(tempNGO);
        }

        setState(() {
          nearbyNGOList.sort((a, b) {
            return a.distance.compareTo(b.distance);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: b * 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sh(50),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: SvgPicture.asset(
                    'images/Arrow1.svg',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              SizedBox(width: b * 10),
              Text(
                'Near By NGOs',
                style: txtS(mc, 20, FontWeight.w500),
              ),
            ],
          ),
          Expanded(
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
                            dialogBoxDonateDone(context);
                            uploadDonationToDB(nearbyNGOList[index].uid);
                          },
                          child: Container(
                            height: h * 120,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: -3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(b * 10),
                              color: Color(0xffff1f1f1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: h * 120,
                                  width: b * 97,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(b * 13),
                                    color: Colors.black12,
                                  ),
                                  child: nearbyNGOList[index].photoUrl == null
                                      ? Image.asset('images/headNoImage.png')
                                      : CachedNetworkImage(
                                          imageUrl:
                                              nearbyNGOList[index].photoUrl,
                                          fit: BoxFit.fitHeight,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(b * 13),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
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
                                        width: b * 200,
                                        child: Text(
                                          nearbyNGOList[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: txtS(
                                              textColor, 20, FontWeight.w600),
                                        ),
                                      ),
                                      sh(5),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: b * 18,
                                            height: h * 22,
                                            decoration: BoxDecoration(
                                              color: mc,
                                              borderRadius:
                                                  BorderRadius.circular(b * 6),
                                            ),
                                            child: Container(
                                              height: h * 14,
                                              width: b * 14,
                                              child: SvgPicture.asset(
                                                'images/rest.svg',
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: b * 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                nearbyNGOList[index]
                                                    .packageNo
                                                    .toString(),
                                                style: txtS(textColor, 10,
                                                    FontWeight.w500),
                                              ),
                                              Text(
                                                'Packages Delivered',
                                                style: txtS(
                                                    rc, 9, FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      sh(5),
                                      nearbyNGOList[index].isVerified
                                          ? Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: b * 18,
                                                  height: h * 18,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff28797c),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            b * 4),
                                                  ),
                                                  child: Icon(Icons.verified,
                                                      color: Colors.white,
                                                      size: b * 11),
                                                ),
                                                SizedBox(width: b * 5),
                                                Text(
                                                  'Verified',
                                                  style: txtS(textColor, 12,
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            nearbyNGOList[index]
                                                    .distance
                                                    .toString() +
                                                " km",
                                            style: txtS(
                                                textColor, 16, FontWeight.w800),
                                          ),
                                          SizedBox(width: b * 10),
                                          Icon(Icons.arrow_right_alt,
                                              color: mc),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        sh(20),
                      ],
                    ),
            ),
          ),
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

  uploadDonationToDB(String ngoUID) async {
    widget.foodPacket.donatedTo = ngoUID;
    var map = widget.foodPacket.toMap();

    map.update('donatedTo', (value) => ngoUID);

    FirebaseFirestore.instance.collection('donations').add(map).then((value) {
      sendNotification(ngoUID);
    }).catchError((error) {
      print(error);
      Toast.show("Error Encountered", context);
    });
  }

  sendNotification(String ngoUID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String donorUID = pref.getString('currentUserUID');

    FirebaseFunctions.instance
        .httpsCallable('sendDonation')
        .call({'ngoUID': widget.foodPacket.donatedTo, 'donorUID': donorUID});
  }
}
