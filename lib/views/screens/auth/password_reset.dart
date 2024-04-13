import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/palette.dart';
import 'package:jmoov/views/components/circle.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  static const routeName = '/password-reset';

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();

  ThemeData get _theme => theme(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Circle(top: -40, left: -40, color: Palette.primaryColor),
          const Circle(top: 300, right: -20, color: Palette.primaryColor),
          const Circle(bottom: -150, size: 450, color: Palette.primaryColor),
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
                          Center(
                            child: Image.asset(
                              'assets/images/logo.webp',
                              height: 64,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Mot de passe oublié',
                            style: _theme.textTheme.headlineLarge,
                          ),
                          GestureDetector(
                            onTap: _pop,
                            child: Text(
                              "Vous avez un compte ? Connectez-vous.",
                              style: _theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(height: 20),
                          IntlPhoneField(
                            decoration:
                                const InputDecoration(hintText: 'Téléphone'),
                            initialCountryCode: 'CI',
                            disableLengthCheck: true,
                            onChanged: (phone) {
                              log(phone.completeNumber);
                            },
                            validator: (p0) {
                              if (p0 == null || p0.number.isEmpty) {
                                return 'Veuillez entrer votre numéro de téléphone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Envoyer le code'),
                          ),
                          const SizedBox(height: 20),
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

  void _pop() {
    Navigator.of(context).pop();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed('/password-reset-code');
    }
  }
}
