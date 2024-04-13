import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jmoov/core/services/auth_service.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/views/components/circle.dart';
import 'package:jmoov/views/components/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  ThemeData get _theme => theme(context);
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService get _authService => AuthService.instance.of(context);

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Circle(top: -40, left: -40),
        const Circle(top: 300, right: -20),
        const Circle(bottom: -150, size: 450),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    child: Card(
                      elevation: 10,
                      color: Colors.white.withOpacity(0.9),
                      shadowColor: _theme.colorScheme.primary.withOpacity(0.2),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: _isLoading
                              ? const Loading()
                              : _LoginForm(
                                  formKey: _formKey,
                                  isPasswordVisible: _isPasswordVisible,
                                  phoneController: _phoneController,
                                  passwordController: _passwordController,
                                  onSubmit: _submit,
                                  onTogglePasswordVisibility: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  onResetPassword: _resetPassword,
                                  onRegister: _register,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }

  void _resetPassword() {
    Navigator.pushNamed(context, '/password-reset');
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.login(
          _phoneController.text,
          _passwordController.text,
        );
        await _authService.ping();

        if (!mounted) return;

        Navigator.pushNamed(context, '/home');
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: _theme.colorScheme.error,
            showCloseIcon: true,
            duration: const Duration(seconds: 30),
          ),
        );
      }
    }
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final bool isPasswordVisible;
  final VoidCallback onSubmit;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onResetPassword;
  final VoidCallback onRegister;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;

  const _LoginForm({
    this.formKey,
    this.isPasswordVisible = false,
    required this.onSubmit,
    required this.onTogglePasswordVisibility,
    required this.onResetPassword,
    required this.onRegister,
    this.phoneController,
    this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData t = theme(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.webp',
              height: 64,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Se connecter',
            style: t.textTheme.headlineLarge,
          ),
          GestureDetector(
            onTap: onRegister,
            child: Text(
              "Vous n'avez pas de compte ? Créez-en un.",
              style: t.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          IntlPhoneField(
            decoration: const InputDecoration(
              hintText: 'Téléphone',
            ),
            onChanged: (value) => {
              phoneController!.text = value.completeNumber,
            },
            initialCountryCode: 'CI',
            disableLengthCheck: true,
            validator: (phone) {
              if (phone == null || phone.number.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: !isPasswordVisible,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Mot de passe',
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Connexion'),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onResetPassword,
            child: Text(
              "Mot de passe oublié ?",
              style: t.textTheme.bodyLarge?.copyWith(
                color: t.colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: t.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
