import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';
import 'widgets/mentora_brand.dart';
import 'widgets/form_field_box.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _key = GlobalKey<FormState>();
  final _contact = TextEditingController();
  final _auth = AuthController();

  @override
  void dispose() { _contact.dispose(); super.dispose(); }

  Future<void> _send() async {
    if (!_key.currentState!.validate()) return;
    final registered = await _auth.resetPassword(_contact.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(registered ? 'Reset code sent.' :
      'Demo mode: connect authentication to check registration and send a code.'),
      duration: const Duration(seconds: 4),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)), title: const MentoraBrand()),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(key: _key, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Text('RESET YOUR PASSWORD',
                style: TextStyle(color: Color(0xFF6E8DA9),
                    fontWeight: FontWeight.bold, letterSpacing: 1.3, fontSize: 11)),
            const SizedBox(height: 12),
            const Text('Forgot password?',
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w800,
                    color: MentoraApp.navy)),
            const SizedBox(height: 12),
            const Text('Enter the email address or phone number connected to your Mentora account. We will help you reset your password.',
                style: TextStyle(color: Colors.black54, height: 1.5)),
            const SizedBox(height: 28),
            FormFieldBox(label: 'Email address or phone number',
                controller: _contact, hint: 'Email or +977 phone number',
                validator: (v) => (v == null || v.trim().length < 5)
                    ? 'Enter a valid email or phone number' : null),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 54, child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: MentoraApp.navy,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                onPressed: _send, child: const Text('Send reset code'))),
            const SizedBox(height: 12),
            Center(child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/sign-in'),
                child: const Text('Back to sign in'))),
          ],
        )),
      )),
    );
  }
}