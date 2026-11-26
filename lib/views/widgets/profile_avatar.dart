import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Rounded square that shows the profile photo, or the first letter of the
/// name when there is no photo yet.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.profile, this.size = 64});

  final UserProfile profile;
  final double size;

  @override
  Widget build(BuildContext context) {
    final bytes = profile.photoBytes;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.tint,
        borderRadius: BorderRadius.circular(size * 0.28),
        image: bytes == null
            ? null
            : DecorationImage(image: MemoryImage(bytes), fit: BoxFit.cover),
      ),
      child: bytes != null
          ? null
          : Text(profile.initial,
          style: AppText.pageTitle.copyWith(fontSize: size * 0.4)),
    );
  }
}