import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gur/models/ngo.dart';
import 'package:gur/screens/mainScreens/aboutNgo.dart';
import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

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
              onTap: () {
                setState(() {
                  tapped = !tapped;
                });
              },
              onChanged: (value) {
                onItemChanged(value);
              },
            ),
          ),
          sh(30),
          Container(
            constraints: BoxConstraints(maxHeight: h * 500, minHeight: h * 240),
            margin: EdgeInsets.symmetric(horizontal: b * 20),
            padding: EdgeInsets.symmetric(horizontal: b * 10, vertical: h * 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(b * 13),
              color: Colors.white,
            ),
            child: isListLoding
                ? SpinKitCircle(
                    color: Colors.orange,
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              newDataList[index].photoUrl),
                                          fit: BoxFit.cover,
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
                                            width: b * 144,
                                            child: Text(
                                              newDataList[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: txtS(textColor, 20,
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: b * 18,
                                                height: h * 18,
                                                decoration: BoxDecoration(
                                                  color: mc,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          b * 4),
                                                ),
                                                child: Icon(Icons.restaurant,
                                                    color: Colors.white,
                                                    size: b * 10),
                                              ),
                                              SizedBox(width: b * 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '12',
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
                                          sh(2),
                                          Row(
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
                                                    size: b * 10),
                                              ),
                                              SizedBox(width: b * 10),
                                              Text(
                                                'Verified',
                                                style: txtS(textColor, 12,
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Working Since 2018',
                                                style: txtS(textColor, 12,
                                                    FontWeight.w500),
                                              ),
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
}
