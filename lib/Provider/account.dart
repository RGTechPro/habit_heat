import 'package:flutter/cupertino.dart';

class Account extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _mobileNo;
  setName(String? name) {
    _name = name;
  }

  setEmail(String? email) {
    _email = email;
  }

  setMobile(String? mobileNo) {
    _mobileNo = mobileNo;
  }

  String? getName() {
    return _name;
  }

  String? getEmail() {
    return _email;
  }

  String? getMobile() {
    return _mobileNo;
  }

  logout() {
    _name = null;
    _mobileNo = null;
    _email = null;
  }

  String city = 'mumbai';
  changeCity(String new_city) {
    this.city = new_city.toLowerCase();
    notifyListeners();
  }
}
