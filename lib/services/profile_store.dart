import 'package:flutter/foundation.dart';

import '../models/account_role.dart';
import '../models/user_profile.dart';

/// Keeps the signed-in user's profile while the app is running.
///
/// There is no backend or database yet, so this class is the "database" for
/// Sprint 2. When the backend is ready, only the inside of these methods
/// changes. Every screen keeps calling the same methods.
class ProfileStore extends ChangeNotifier {
  ProfileStore._();

  static final ProfileStore instance = ProfileStore._();

  UserProfile? _current;

  /// The signed-in user, or null when nobody is signed in.
  UserProfile? get current => _current;

  void signIn(UserProfile profile) {
    _current = profile;
    notifyListeners();
  }

  /// Saves an edited profile (name, phone, photo, ...).
  void update(UserProfile profile) {
    _current = profile;
    notifyListeners();
  }

  void signOut() {
    _current = null;
    notifyListeners();
  }

  /// Temporary profile used by the sign-in page until real login exists.
  UserProfile demoProfile(AccountRole role, String email) {
    final handle = email.contains('@') ? email.split('@').first : '';
    final fallback = role == AccountRole.teacher ? 'Teacher' : 'Student';
    return UserProfile(
      role: role,
      name: handle.isEmpty ? fallback : handle,
      email: email,
    );
  }
}