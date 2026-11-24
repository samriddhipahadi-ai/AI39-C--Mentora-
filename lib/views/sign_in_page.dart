import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';
import 'widgets/mentora_brand.dart';
import 'widgets/form_field_box.dart';
import '../models/account_role.dart';
import '../models/user_profile.dart';
import '../services/profile_store.dart';
import '../theme/app_text_styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = AuthController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_key.currentState!.validate()) return;
    await _auth.signIn(email: _email.text.trim(), password: _password.text);
    if (!mounted) return;

    // TODO(backend): continue only when the real sign-in works, and read the
    // role from the database. Until then, a new account (just registered) is
    // reused, otherwise the person picks a role by hand.
    final profile = ProfileStore.instance.current ?? await _pickDemoRole();
    if (profile == null || !mounted) return;

    ProfileStore.instance.signIn(profile);
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }

  /// Temporary: there is no backend, so ask which dashboard to open.
  Future<UserProfile?> _pickDemoRole() {
    final email = _email.text.trim();
    return showModalBottomSheet<UserProfile>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demo sign-in', style: AppText.sectionTitle),
              const SizedBox(height: 6),
              Text('There is no backend yet. Choose which dashboard to open.',
                  style: AppText.body),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(sheetContext,
                      ProfileStore.instance.demoProfile(AccountRole.student, email)),
                  child: const Text('Continue as student'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(sheetContext,
                      ProfileStore.instance.demoProfile(AccountRole.teacher, email)),
                  child: const Text('Continue as teacher'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: const MentoraBrand()),
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('WELCOME BACK',
                            style: TextStyle(
                                color: Color(0xFF6E8DA9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 11)),
                        const SizedBox(height: 12),
                        const Text('Continue your journey.',
                            style: TextStyle(
                                fontSize: 31,
                                fontWeight: FontWeight.w800,
                                color: MentoraApp.navy)),
                        const SizedBox(height: 8),
                        const Text(
                            'Sign in to your personal student or teacher dashboard.',
                            style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 28),
                        FormFieldBox(
                            label: 'Email address',
                            controller: _email,
                            hint: 'you@example.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => (v == null || !v.contains('@'))
                                ? 'Enter a valid email'
                                : null),
                        const SizedBox(height: 20),
                        FormFieldBox(
                            label: 'Password',
                            controller: _password,
                            hint: 'Enter your password',
                            obscureText: true,
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Password is required'
                                : null),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/forgot-password'),
                              child: const Text('Forgot password?',
                                  style: TextStyle(color: Colors.grey, fontSize: 12)),
                            )),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: MentoraApp.navy,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              onPressed: _signIn,
                              child: const Text('Sign in',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(height: 18),
                        Center(
                            child: TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/create-account'),
                                child: const Text('New to Mentora? Create account'))),
                        Center(
                            child: TextButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Admin login page is not part of Sprint 1 yet.'))),
                                child: const Text('Admin Login',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline)))),
                      ],
                    )),
              ))),
    );
  }
}