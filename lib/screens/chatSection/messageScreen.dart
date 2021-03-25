import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gur/screens/chatSection/chatScreen.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';

class MessageScreen extends StatefulWidget {
  final String uid;
  MessageScreen(this.uid);
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List donorList = [];

  loadMainList() async {
    FirebaseFirestore.instance
        .collection('donorChat')
        .snapshots()
        .listen((snapshot) {
      List<QueryDocumentSnapshot> documentSnapshot = snapshot.docs;

      setState(() {
        for (var i in documentSnapshot) {
          donorList.add(i.data()['name']);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    loadMainList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: b * 5),
                          height: h * 30,
                          width: b * 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: mc, width: b * 1.5),
                            borderRadius: BorderRadius.circular(b * 12),
                          ),
                          child: Icon(Icons.arrow_back_ios,
                              color: mc, size: b * 16),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Text(
                    'Messages',
                    style: txtS(mc, 20, FontWeight.w600),
                  ),
                  Spacer(),
                ],
              ),
            ),
            sh(30),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('donorChats')
                  .doc('lists')
                  .collection(widget.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                else if (snapshot.data.docs.length == 0)
                  return Center(child: Text('Woops ! No Chat so far'));
                else
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) => Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ChatScreen(
                                    snapshot.data.docs[index]['uid'],
                                    widget.uid);
                              }));
                            },
                            child: Container(
                              height: h * 90,
                              margin: EdgeInsets.symmetric(
                                  horizontal: b * 20, vertical: h * 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: b * 10, vertical: h * 8.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(b * 20),
                                color: Color(0xffff1f1f1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: b * 69 / 2,
                                    backgroundColor: gc,
                                  ),
                                  SizedBox(width: b * 15),
                                  Container(
                                    width: b * 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.docs[index]['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: txtS(
                                              textColor, 16, FontWeight.w600),
                                        ),
                                        Text(
                                          "Tap to chat",
                                          style: txtS(Color(0xff7d7d7d), 12,
                                              FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: b * 20, top: h * 16.5),
                                    child: Text(
                                      "18:34",
                                      style: txtS(Color(0xff7d7d7d), 10,
                                          FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ]),
        ),
      ),
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
