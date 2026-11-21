class AuthService {
  Future<bool> createAccount({
    required String email,
    required String password,
    required String role,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true; // Demo only; not a real registered account.
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return false; // Demo: no real account database is connected.
  }

  Future<bool> requestPasswordReset(String contact) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return false; // Demo: cannot verify registration or send a code.
  }
}
