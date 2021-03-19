import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:gur/Utils/SizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:bubble/bubble.dart';
import 'Utils/constants.dart';
import 'Utils/SizeConfig.dart';

class ChatScreen extends StatefulWidget {
  String name;
  String email;
  String photoUrl;
  String receiverUid;
  String role;
  ChatScreen({
    this.name,
    this.photoUrl,
    this.receiverUid,
    this.role,
    this.email,
  });

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController;

  ScrollController _scrollController = new ScrollController();
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  CollectionReference _collectionReference;
  DocumentSnapshot documentSnapshot;
  String _senderuid;
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
    getUID().then((user) {
      setState(() {
        _senderuid = user.uid;
        print("sender uid : $_senderuid");
        getSenderPhotoUrl(_senderuid).then((snapshot) {
          setState(() {
            senderPhotoUrl = snapshot['photoUrl'];
            senderName = snapshot['name'];
          });
        });
        getReceiverPhotoUrl(widget.receiverUid).then((snapshot) {
          setState(() {
            receiverPhotoUrl = snapshot['photoUrl'];
            receiverName = snapshot['name'];
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  /*void addMessageToDb(Message message) async {
    map = message.toMap();
    _collectionReference = FirebaseFirestore.instance
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
  }*/

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _senderuid == null
            ? Container(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
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
                                    border:
                                        Border.all(color: mc, width: b * 1.5),
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
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;
    return Container(
      padding: EdgeInsets.fromLTRB(
        b * 5,
        h * 7,
        b * 55,
        h * 7,
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
                  fontSize: b * 14 / 360,
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
                    fontSize: b * 14 / 360,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: h * 12,
                    horizontal: b * 10 / 360,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: b * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      b * 25 / 360,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: b * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      b * 25 / 360,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: b * 1 / 360,
                    ),
                    borderRadius: BorderRadius.circular(
                      b * 25 / 360,
                    ),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.grey[400],
                      size: b * 20 / 360,
                    ),
                    /*onTap: () {
                      tolast();
                      if (_formKey.currentState.validate()) {
                        sendMessage();
                      }
                    },*/
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

  /* void sendMessage() async {
    var text = _messageController.text;
    _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : $_senderuid , message: $text");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }*/

  Future<User> getUID() async {
    //User user = await _firebaseAuth.currentUser();
    User user = FirebaseAuth.instance.currentUser;
    return user;
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
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    print("SENDERUID : $_senderuid");
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(_senderuid)
            .collection(widget.receiverUid)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            int rev = snapshot.data.documents.length - 1;
            listItem = snapshot.data.documents;
            return ListView.builder(
              physics: ScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: b * 10 / 360,
                vertical: h * 10,
              ),
              reverse: true,
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.documents[rev - index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
    return buildChatLayout(documentSnapshot);
  }

  Widget buildChatLayout(DocumentSnapshot snapshot) {
    var b = SizeConfig.screenWidth / 414;
    var h = SizeConfig.screenHeight / 896;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: b * 5 / 360,
          ),
          child: Row(
            mainAxisAlignment: snapshot['senderUid'] == _senderuid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              snapshot['senderUid'] == _senderuid
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot['type'] == 'text'
                            ? Align(
                                child: Bubble(
                                  nipWidth: b * 5 / 360,
                                  nipRadius: b * 2 / 360,
                                  margin: BubbleEdges.all(0),
                                  padding: BubbleEdges.all(0),
                                  nip: BubbleNip.rightBottom,
                                  color: Color.fromRGBO(48, 82, 117, 0.9),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      b * 14 / 360,
                                      h * 8,
                                      b * 8 / 360,
                                      h * 4,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 0,
                                      maxWidth: b * 0.55,
                                    ),
                                    child: snapshot['message'].length > 28
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, b * 3 / 360, 0),
                                                child: SelectableText(
                                                  (snapshot['message']).trim(),
                                                  maxLines: null,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: b * 12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * 7 / 640,
                                              ),
                                              Text(
                                                giveTime(snapshot['timestamp']),
                                                style: TextStyle(
                                                  fontSize: b * 10 / 360,
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0,
                                                  b * 5 / 360,
                                                  h * 5 / 640,
                                                ),
                                                child: SelectableText(
                                                  snapshot['message'],
                                                  maxLines: null,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: b * 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: h * 2 / 640,
                                                  right: b * 3 / 360,
                                                ),
                                                child: Text(
                                                  giveTime(
                                                      snapshot['timestamp']),
                                                  style: TextStyle(
                                                    fontSize: b * 10,
                                                    color: Colors.white60,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: h * 3,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot['type'] == 'text'
                            ? Align(
                                child: Bubble(
                                  margin: BubbleEdges.all(0),
                                  padding: BubbleEdges.all(0),
                                  nipWidth: b * 5 / 360,
                                  nipRadius: b * 2 / 360,
                                  nip: BubbleNip.leftTop,
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      b * 14 / 360,
                                      h * 8,
                                      b * 5 / 360,
                                      h * 4,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 0,
                                      maxWidth: b * 0.55,
                                    ),
                                    child: snapshot['message'].length > 28
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0,
                                                  b * 10 / 360,
                                                  0,
                                                ),
                                                child: SelectableText(
                                                  snapshot['message'],
                                                  maxLines: null,
                                                  style: TextStyle(
                                                    color: Color(0xff1c1c1c),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: b * 12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * 7 / 640,
                                              ),
                                              Text(
                                                giveTime(snapshot['timestamp']),
                                                style: TextStyle(
                                                  fontSize: b * 10 / 360,
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0,
                                                  b * 3 / 360,
                                                  h * 4 / 640,
                                                ),
                                                child: SelectableText(
                                                  snapshot['message'],
                                                  maxLines: null,
                                                  style: TextStyle(
                                                    color: Color(0xff1c1c1c),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: b * 12,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: h * 2 / 640,
                                                  right: b * 3 / 360,
                                                ),
                                                child: Text(
                                                  giveTime(
                                                      snapshot['timestamp']),
                                                  style: TextStyle(
                                                    fontSize: b * 10,
                                                    color: Colors.grey[800],
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 3),
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
