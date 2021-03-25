import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  String name;
  String email;
  String phone;
  String uid;
  String token;
  String address;
  String userType;
  FieldValue regDate;

  CurrentUser(
      {this.name,
      this.email,
      this.phone,
      this.uid,
      this.token,
      this.address,
      this.userType,
      this.regDate});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['uid'] = this.uid;
    map['token'] = this.token;
    map['address'] = this.address;
    map['userType'] = this.userType;
    map['regDate'] = this.regDate;
    return map;
  }

  CurrentUser fromMap(Map<String, dynamic> map) {
    CurrentUser _currentUser = CurrentUser();
    _currentUser.name = map['name'];
    _currentUser.email = map['email'];
    _currentUser.phone = map['phone'];
    _currentUser.uid = map['uid'];
    _currentUser.token = map['token'];
    _currentUser.address = map['address'];
    _currentUser.userType = map['userType'];
    _currentUser.regDate = map['regDate'];
    return _currentUser;
  }
}
