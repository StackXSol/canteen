class appUser {
  String full_name;
  String email;
  String phone;
  String uid;
  String College;
  String Roll_no;
  appUser({
    required this.College,
    required this.full_name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.Roll_no,
  });
}

class canteenUser {
  String _canteenName = "";
  String _email = "";
  String _phone = "";
  String _uid = "";
  String _college = "";

  void setter(cname, email, phone, uid, college) {
    this._canteenName = cname;
    this._email = email;
    this._phone = phone;
    this._uid = uid;
    this._college = college;
  }

  List<String> getter() {
    return [_canteenName, _email, _phone, _uid, _college];
  }
}
