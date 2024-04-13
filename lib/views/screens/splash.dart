import 'package:flutter/material.dart';
import 'package:jmoov/core/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService get _authService => AuthService.instance.of(context);

  _init() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _authService.autoLogin();
      await _authService.ping();
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.webp', width: 200),
          const SizedBox(height: 32),
          const CircularProgressIndicator(),
        ],
      )),
    );
  }
}
