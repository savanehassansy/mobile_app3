import 'package:flutter/material.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:jmoov/palette.dart';
import 'package:jmoov/views/screens/auth/login.dart';
import 'package:jmoov/views/screens/auth/password_reset.dart';
import 'package:jmoov/views/screens/auth/register.dart';
import 'package:jmoov/views/screens/home.dart';
import 'package:jmoov/views/screens/splash.dart';
import 'package:jmoov/views/screens/subscription.dart';
import 'package:jmoov/views/screens/user/my_subscriptions.dart';
import 'package:jmoov/views/screens/user/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "J'Moov Free",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: Palette.primaryColor,
            foregroundColor: Colors.white,
            fixedSize: const Size.fromHeight(48),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            foregroundColor: Palette.accentColor,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Palette.accentColor,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 1,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey.withOpacity(0.2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SubscriptionScreen.routeName: (context) => const SubscriptionScreen(),

        // Auth
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        PasswordResetScreen.routeName: (context) => const PasswordResetScreen(),

        // User
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        MySubscriptionsScreen.routeName: (context) =>
            const MySubscriptionsScreen(),
      },
    );
  }
}
