
import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import 'profile_avatar.dart';
import 'section_card.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.subtitle,
    required this.editing,
    required this.onToggleEdit,
    this.avatar,
  });

  final UserProfile profile;
  final String subtitle;
  final bool editing;
  final VoidCallback onToggleEdit;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: profile.name,
      subtitle: subtitle,
      child: Row(
        children: [
          avatar ??
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
          ),
        ],
      ),
    );
  }
}
