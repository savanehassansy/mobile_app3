import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/views/components/circle.dart';
import 'package:jmoov/views/components/labelled.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  ThemeData get _theme => theme(context);
  bool _isPasswordVisible = false;

  IconData get _icon =>
      _isPasswordVisible ? Icons.visibility : Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.webp'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Se connecter'),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Circle(top: -40, left: -40),
          const Circle(top: 150, right: -20),
          const Circle(bottom: -150, size: 450),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 10,
                  color: Colors.white.withOpacity(0.9),
                  shadowColor: _theme.colorScheme.primary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            'Créer nouveau compte',
                            style: _theme.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 20),
                          Labelled(
                            label: "Numéro de téléphone",
                            child: IntlPhoneField(
                              decoration: const InputDecoration(
                                hintText: 'Téléphone',
                              ),
                              initialCountryCode: 'CI',
                              disableLengthCheck: true,
                              onChanged: (phone) {
                                log(phone.completeNumber);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Labelled(
                            label: "Mot de passe",
                            child: TextField(
                              obscureText: _isPasswordVisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _togglePasswordVisibility,
                                  icon: Icon(_icon),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Labelled(
                            label: "Confirmation du mot de passe",
                            child: TextField(
                              obscureText: _isPasswordVisible,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _togglePasswordVisibility,
                                  icon: Icon(_icon),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Continuer'),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {}

  void _togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    setState(() {});
  }
}
