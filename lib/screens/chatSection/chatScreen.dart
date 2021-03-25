import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:gur/Utils/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:gur/Utils/messageUI.dart';
import 'package:gur/models/msg.dart';
import '../../Utils/constants.dart';
import '../../Utils/SizeConfig.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUid;
  final String senderUID;

  ChatScreen(this.receiverUid, this.senderUID);

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController;

  ScrollController _scrollController = new ScrollController();
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  CollectionReference _collectionReference;
  DocumentSnapshot documentSnapshot;
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  StreamSubscription<DocumentSnapshot> subscription;
  File imageFile;
  TextEditingController _messageController;

  void tolast() {
    _scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1),
    );
  }

  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void addMessageToDb(Message message) async {
    map = message.toMap();
    _collectionReference = FirebaseFirestore.instance
        .collection('donorChats')
        .doc('messages')
        .collection("messages")
        .doc(message.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(message.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });
    _messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                          onTap: () {},
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
              ChatMessagesListWidget(),
              ChatInputWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ChatInputWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 5 / 360,
        vertical: SizeConfig.screenHeight * 7 / 640,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextFormField(
                validator: (String input) {
                  if (input.isEmpty) {
                    return "Please enter message";
                  }
                  return null;
                },
                style: TextStyle(
                  color: Color(0xff1c1c1c),
                  fontSize: SizeConfig.screenWidth * 14 / 360,
                  fontWeight: FontWeight.w400,
                ),
                minLines: 1,
                maxLines: 4,
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  errorStyle: TextStyle(color: Colors.transparent),
                  hintStyle: TextStyle(
                    color: Color(0xff1c1c1c),
                    fontSize: SizeConfig.screenWidth * 14 / 360,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight * 12 / 640,
                    horizontal: SizeConfig.screenWidth * 10 / 360,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: SizeConfig.screenWidth * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.screenWidth * 25 / 360,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: SizeConfig.screenWidth * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.screenWidth * 25 / 360,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: SizeConfig.screenWidth * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.screenWidth * 25 / 360,
                    ),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.grey[400],
                      size: SizeConfig.screenWidth * 20 / 360,
                    ),
                    onTap: () {
                      tolast();
                      if (_formKey.currentState.validate()) {
                        //sendNotification(_messageController.text);
                        //initLocalDB(_messageController.text);
                        sendMessage();
                      }
                    },
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onFieldSubmitted: (value) {
                  _messageController.text = value;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 5 / 360,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.photo,
                  color: Color.fromARGB(220, 255, 255, 255),
                  size: SizeConfig.screenWidth * 20 / 360,
                ),
                onPressed: () {}),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 5 / 360,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.video_label,
                  size: SizeConfig.screenWidth * 20 / 360,
                  color: Color.fromARGB(220, 255, 255, 255),
                ),
                onPressed: () {}),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: h * h / 896);
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 414,
    );
  }

  void sendMessage() async {
    var text = _messageController.text;
    Message _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: widget.senderUID,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : $widget.senderUID , message: $text");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }

  Future<DocumentSnapshot> getSenderPhotoUrl(String uid) {
    var senderDocumentSnapshot =
        FirebaseFirestore.instance.collection('users').doc(uid).get();
    return senderDocumentSnapshot;
  }

  Future<DocumentSnapshot> getReceiverPhotoUrl(String uid) {
    var receiverDocumentSnapshot =
        FirebaseFirestore.instance.collection('users').doc(uid).get();
    return receiverDocumentSnapshot;
  }

  Widget ChatMessagesListWidget() {
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donorChats')
            .doc('messages')
            .collection('messages')
            .doc(widget.senderUID)
            .collection(widget.receiverUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            int rev = snapshot.data.docs.length - 1;
            listItem = snapshot.data.docs;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 10 / 360,
                vertical: SizeConfig.screenHeight * 10 / 640,
              ),
              reverse: true,
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.docs[rev - index]),
              itemCount: snapshot.data.docs.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
    return buildChatLayout(documentSnapshot);
  }

  Widget buildChatLayout(DocumentSnapshot snap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 5 / 360,
          ),
          child: Row(
            mainAxisAlignment: snap['senderUid'] == widget.senderUID
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              snap['senderUid'] == widget.senderUID
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snap['type'] == 'text'
                            ? Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                  painter: ChatBubble(
                                    color: Color.fromRGBO(242, 108, 37, 0.9),
                                    alignment: Alignment.topRight,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      SizeConfig.screenWidth * 14 / 360,
                                      SizeConfig.screenHeight * 9 / 640,
                                      SizeConfig.screenWidth * 10 / 360,
                                      SizeConfig.screenHeight * 2 / 640,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 0,
                                      maxWidth: SizeConfig.screenWidth * 0.55,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                SizeConfig.screenWidth *
                                                    10 /
                                                    360,
                                                0),
                                            child: Text(
                                              snap['message'],
                                              maxLines: null,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        12 /
                                                        360,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  7 /
                                                  640),
                                          Text(
                                            giveTime(snap['timestamp']),
                                            style: TextStyle(
                                              fontSize: SizeConfig.screenWidth *
                                                  10 /
                                                  360,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.b * 0.764),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snap['type'] == 'text'
                            ? Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                  painter: ChatBubble(
                                    color: Colors.white,
                                    alignment: Alignment.topLeft,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      SizeConfig.screenWidth * 15 / 360,
                                      SizeConfig.screenHeight * 9 / 640,
                                      SizeConfig.screenWidth * 5 / 360,
                                      SizeConfig.screenHeight * 4 / 640,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 0,
                                      maxWidth: SizeConfig.screenWidth * 0.55,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                SizeConfig.screenWidth *
                                                    10 /
                                                    360,
                                                0),
                                            child: Text(
                                              snap['message'],
                                              maxLines: null,
                                              style: TextStyle(
                                                color: Color(0xff1c1c1c),
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        12 /
                                                        360,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  7 /
                                                  640),
                                          Text(
                                            giveTime(snap['timestamp']),
                                            style: TextStyle(
                                              fontSize: SizeConfig.screenWidth *
                                                  10 /
                                                  360,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.b * 0.764),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }

  String giveTime(Timestamp timestamp) {
    DateTime d = timestamp.toDate();
    String time = d.toString().substring(11, 16);
    return time;
  }

  /*Future<void> sendNotification(String textMessage) async {
    FirebaseFunctions firebaseFunctions = FirebaseFunctions.instance;

    await firebaseFunctions.httpsCallable('sendNotification').call(
      <String, dynamic>{
        "recieverId": widget.receiverUid,
        "messageTxt": textMessage,
        "senderName": senderName
      },
    );
  }*/

}
