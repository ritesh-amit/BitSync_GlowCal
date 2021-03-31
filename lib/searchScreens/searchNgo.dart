import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gur/models/ngo.dart';
import 'package:gur/screens/mainScreens/aboutNgo.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTextController = TextEditingController();
  List<NGO> mainDataList = [];
  List<NGO> newDataList = [];
  bool isListLoding = true;
  bool tapped = false;
  @override
  void initState() {
    super.initState();

    loadList();
  }

  loadList() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'ngo')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> completeList = snapshot.docs;

      for (var i in completeList) {
        NGO tempNGO = NGO(
            name: i.data()['name'],
            photoUrl: i.data()['image1'],
            uid: i.data()['uid']);

        mainDataList.add(tempNGO);
      }

      mainDataList.sort((a, b) {
        return a.name.compareTo(b.name);
      });

      setState(() {
        newDataList = List.from(mainDataList);
        isListLoding = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return SingleChildScrollView(
      child: Container(
        margin: MediaQuery.of(context).viewInsets,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: b * 23),
            height: h * 50,
            width: 374 * b,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(b * 50),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: searchTextController,
              style: txtS(textColor, 18, FontWeight.w500),
              decoration: dec('Search for NGO name...'),
              onChanged: (value) {
                onItemChanged(value);
              },
            ),
          ),
          sh(30),
          Container(
            constraints: BoxConstraints(maxHeight: h * 600, minHeight: h * 100),
            margin: EdgeInsets.symmetric(horizontal: b * 20),
            padding: EdgeInsets.symmetric(horizontal: b * 15, vertical: h * 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(b * 13),
              color: Colors.white,
            ),
            child: isListLoding
                ? SpinKitCircle(
                    color: mc,
                  )
                : newDataList.length == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Oops! No NGO found of this name",
                            style: txtS(textColor, 20, FontWeight.w500),
                          ),
                        ],
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: newDataList.length,
                        itemBuilder: (context, index) => Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return AboutNgo(
                                      uidNGO: newDataList[index].uid,
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: h * 12, bottom: h * 12),
                                height: h * 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(b * 20),
                                  color: Color(0xffff1f1f1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: b * 4,
                                      spreadRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: h * 100,
                                      width: b * 97,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(b * 13),
                                        color: Colors.black12,
                                      ),
                                      child: newDataList[index].photoUrl == null
                                          ? Image.asset(
                                              'images/headNoImage.png')
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  newDataList[index].photoUrl,
                                              fit: BoxFit.fitHeight,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          b * 10),
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
                                            width: b * 250,
                                            child: Text(
                                              newDataList[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: txtS(textColor, 20,
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          sh(20),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: b * 24,
                                                height: h * 24,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff28797c),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          b * 6),
                                                ),
                                                child: Icon(Icons.verified,
                                                    color: Colors.white,
                                                    size: b * 14),
                                              ),
                                              SizedBox(width: b * 10),
                                              Text(
                                                'Verified',
                                                style: txtS(textColor, 14,
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Working Since 2021',
                                                style: txtS(textColor, 12,
                                                    FontWeight.w500),
                                              ),
                                              SizedBox(width: b * 10),
                                            ],
                                          ),
                                          sh(3),
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
    );
  }

  InputDecoration dec(String txt) {
    return InputDecoration(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: txt,
      hintStyle: TextStyle(
        color: Colors.grey,
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

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((ngo) => ngo.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  onItemRecieved() {}
}
