import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

/// Dark blue banner with a white button ("Learn better, together." and
/// "Continue teaching."). Used on the student and teacher home pages.
class MentoraBanner extends StatelessWidget {
  const MentoraBanner({
    super.key,
    required this.chip,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String chip;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              chip.toUpperCase(),
              style: AppText.eyebrow.copyWith(color: Colors.white, fontSize: 9),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: AppText.sectionTitle.copyWith(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(message, style: AppText.body.copyWith(color: Colors.white70)),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.navy,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onPressed,
            child: Text(buttonLabel, style: AppText.button),
          ),
        ],
      ),
    );
  }
}