import 'package:flutter/material.dart';
import 'views/welcome_page.dart';
import 'views/account_registration_page.dart';
import 'views/sign_in_page.dart';
import 'views/forgot_password_page.dart';

void main() {
  runApp(const MentoraApp());
}

class MentoraApp extends StatelessWidget {
  const MentoraApp({super.key});

  static const navy = Color(0xFF203A56);
  static const blue = Color(0xFF294B6C);
  static const pale = Color(0xFFF5F8FB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pale,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFDCE4EC)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFDCE4EC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: blue, width: 1.6),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const WelcomePage(),
        '/create-account': (_) => const AccountRegistrationPage(),
        '/sign-in': (_) => const SignInPage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
      },
    );
  }
}
