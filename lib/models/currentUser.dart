class CurrentUser {
  String name;
  String email;
  String phone;
  String uid;
  String token;

  CurrentUser({this.name, this.email, this.phone, this.uid, this.token});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['uid'] = this.uid;
    map['token'] = this.token;
    return map;
  }

  CurrentUser fromMap(Map<String, dynamic> map) {
    CurrentUser _message = CurrentUser();
    _message.name = map['name'];
    _message.email = map['email'];
    _message.phone = map['phone'];
    _message.uid = map['uid'];
    _message.token = map['token'];
    return _message;
  }
}
