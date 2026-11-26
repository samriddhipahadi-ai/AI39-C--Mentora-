import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import 'profile_avatar.dart';

// PLACEHOLDER. Kritima replaces this whole file on Day 4 (story 2.3).
// Keep the constructor exactly like this so the profile pages keep working.
class ProfilePhotoPicker extends StatelessWidget {
  const ProfilePhotoPicker({
    super.key,
    required this.profile,
    required this.onChanged,
    this.size = 64,
  });

  final UserProfile profile;
  final ValueChanged<Uint8List> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ProfileAvatar(profile: profile, size: size);
  }
}