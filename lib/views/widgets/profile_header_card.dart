import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
<<<<<<< HEAD
import 'profile_avatar.dart';
import 'section_card.dart';

=======
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'profile_avatar.dart';

/// Dark blue card at the top of the profile page: avatar, name, role badge
/// and the "Edit profile" / "Cancel" button.
>>>>>>> origin/tanu
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.subtitle,
    required this.editing,
    required this.onToggleEdit,
<<<<<<< HEAD
=======
    this.avatar,
>>>>>>> origin/tanu
  });

  final UserProfile profile;
  final String subtitle;
  final bool editing;
  final VoidCallback onToggleEdit;

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: profile.name,
      subtitle: subtitle,
      child: Row(
        children: [
          ProfileAvatar(
            profile: profile,
            size: 72,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              profile.email,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
              ),
            ),
          ),
          IconButton(
            onPressed: onToggleEdit,
            icon: Icon(
              editing ? Icons.close : Icons.edit_outlined,
            ),
            tooltip: editing ? 'Cancel editing' : 'Edit profile',
=======
  /// Replaces the plain avatar. The photo picker goes here in edit mode.
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Row(
            children: [
              avatar ?? ProfileAvatar(profile: profile, size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.successTint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        profile.isTeacher
                            ? 'Verified teacher'
                            : 'Verified student',
                        style: AppText.chip,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      profile.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.pageTitle
                          .copyWith(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: AppText.small.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.navy,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onToggleEdit,
              child: Text(editing ? 'Cancel' : 'Edit profile',
                  style: AppText.button),
            ),
>>>>>>> origin/tanu
          ),
        ],
      ),
    );
  }
}