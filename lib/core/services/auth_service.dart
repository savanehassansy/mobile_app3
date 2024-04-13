import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jmoov/core/apis/auth_api.dart';
import 'package:jmoov/core/models/user.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._();
  final AuthApi _authApi = AuthApi.instance;
  BuildContext? _context;

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  AppProvider? get _provider => _context == null
      ? null
      : Provider.of<AppProvider>(_context!, listen: false);

  AuthService._();

  AuthService of(BuildContext context) {
    _context = context;
    return this;
  }

  static AuthService get instance => _instance;

  Future<void> login(String email, String password) async {
    _checkContext();
    SharedPreferences prefs = await _prefs;

    Map<String, dynamic> data = await _authApi.login(email, password);
    String token = data['token'];
    User user = User.fromJson(data['user']);

    await prefs.setString('token', data['token']);
    await prefs.setString('user', jsonEncode(data['user']));

    _provider!.token = token;
    _provider!.user = user;
    // return LoginResponse(token: data['token'], user: user);
  }

  Future<void> ping() async {
    _checkContext();
    _provider!.homeInfos = await _authApi.ping(_provider!.token!);
  }

  Future<void> autoLogin() async {
    _checkContext();
    SharedPreferences prefs = await _prefs;

    String? token = prefs.getString('token');
    if (token == null) throw Exception('No token found');
    User user = User.fromJson((await _authApi.getUser(token))['user']);

    _provider!.token = token;
    _provider!.user = user;
  }

  Future<void> logout() async {
    _checkContext();
    SharedPreferences prefs = await _prefs;

    await _authApi.logout(_provider!.token!);
    await prefs.remove('token');
    await prefs.remove('user');

    _provider!.token = null;
    _provider!.user = null;
  }

  Future<void> updateGeneralInfo(User user) async {
    _checkContext();
    await _authApi.updateGeneralInfo(user, _provider!.token!);
    _provider!.user = user;
  }

  Future<void> register(String phone, String password, String name) async {
    _checkContext();
    await _authApi.register(phone, password, name);
  }

  Future<void> resetPassword(String phone) async {
    _checkContext();
    await _authApi.resetPassword(phone);
  }

  Future<void> verifyCode(String phone, String code) async {
    _checkContext();
    await _authApi.verifyCode(phone, code);
  }

  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    _checkContext();
    await _authApi.updatePassword(
      currentPassword,
      newPassword,
      confirmNewPassword,
      _provider!.token!,
    );
  }

  Future<void> updateMobile(String mobile, String password) async {
    _checkContext();
    await _authApi.updateMobile(mobile, password, _provider!.token!);
    _provider!.user = _provider!.user!.copyWith(mobile: mobile);
  }

  _checkContext() {
    if (_context == null) throw Exception('No context found');
  }
}
