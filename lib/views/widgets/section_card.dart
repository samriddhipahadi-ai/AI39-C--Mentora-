import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// White rounded card with an optional small label, title and subtitle.
/// Used all over the dashboards and profile pages.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    this.eyebrow,
    this.title,
    this.subtitle,
    required this.child,
  });

  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasHeading = eyebrow != null || title != null;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (eyebrow != null) ...[
            Text(eyebrow!.toUpperCase(), style: AppText.eyebrow),
            const SizedBox(height: 6),
          ],
          if (title != null) Text(title!, style: AppText.cardTitle),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: AppText.body),
          ],
          if (hasHeading) const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}