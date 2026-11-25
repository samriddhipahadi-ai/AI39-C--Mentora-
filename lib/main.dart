import 'package:flutter/material.dart';

import 'package:mentora/views/dashboard/dashboard_shell.dart';
import 'package:mentora/views/account_registration_page.dart';
import 'package:mentora/views/welcome_page.dart';
import 'package:mentora/views/sign_in_page.dart';
import 'package:mentora/views/forget_password_page.dart';

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
        // DM Sans for all body text (turned off in tests, they have no internet).

        colorScheme: ColorScheme.fromSeed(
          seedColor: navy,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: Color(0xFFDCE4EC),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: Color(0xFFDCE4EC),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: blue,
              width: 1.6,
            ),
          ),
        ),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const WelcomePage(),

        '/create-account': (context) =>
        const AccountRegistrationPage(),

        '/sign-in': (context) => const SignInPage(),

        '/forgot-password': (context) =>
        const ForgotPasswordPage(),

        '/dashboard': (context) => const DashboardShell(),
      },
    );
  }
}