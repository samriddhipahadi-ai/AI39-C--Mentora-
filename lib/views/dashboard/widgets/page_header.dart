import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

/// Big title at the top of a tab page:
///   FIND THE RIGHT MENTOR
///   Learn your way.
///   Discover approved teachers and ...
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.centered = false,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final align = centered ? TextAlign.center : TextAlign.start;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment:
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            textAlign: align,
            style: AppText.eyebrow.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Text(title, textAlign: align, style: AppText.pageTitle),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: align, style: AppText.body),
        ],
      ),
    );
  }
}