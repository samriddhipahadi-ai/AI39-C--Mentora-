
import 'package:flutter/material.dart';

import '../../models/user_profile.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profile,
    this.size = 64,
  });

  final UserProfile profile;
  final double size;

  @override
  Widget build(BuildContext context) {
    final photo = profile.photoBytes;

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFFE8EEF5),
      backgroundImage: photo != null ? MemoryImage(photo) : null,
      child: photo == null
          ? Text(
        profile.initial,
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF203A56),
        ),
      )
          : null,
    );
  }
}
