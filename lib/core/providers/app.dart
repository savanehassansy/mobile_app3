import 'package:flutter/material.dart';
import 'package:jmoov/core/models/user.dart';

class AppProvider extends ChangeNotifier {
  Map<String, dynamic> _homeInfos = {};
  User? _user;
  String? _token;

  Map<String, dynamic> get homeInfos => _homeInfos;
  User? get user => _user;
  String? get token => _token;

  set homeInfos(Map<String, dynamic> value) {
    _homeInfos = value;
    notifyListeners();
  }

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  set token(String? token) {
    _token = token;
    notifyListeners();
  }
}
