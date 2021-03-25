import 'package:cloud_firestore/cloud_firestore.dart';

class ContactCard {
  String senderUID;
  String recieverUID;
  String phoneNo;
  String name;
  String type;
  FieldValue timestamp;

  ContactCard(
      this.senderUID, this.recieverUID, this.phoneNo, this.name, this.type);

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUID;
    map['receiverUid'] = this.recieverUID;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['phone'] = this.phoneNo;
    map['name'] = this.name;
    return map;
  }
}
