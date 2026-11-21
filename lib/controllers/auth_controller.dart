import '../services/auth_service.dart';

class AuthController {
  AuthController({AuthService? service}) : _service = service ?? AuthService();

  final AuthService _service;

  Future<bool> createAccount({
    required String email,
    required String password,
    required String role,
  }) {
    return _service.createAccount(email: email, password: password, role: role);
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) {
    return _service.signIn(email: email, password: password);
  }

  Future<bool> resetPassword(String contact) {
    return _service.requestPasswordReset(contact);
  }
}
