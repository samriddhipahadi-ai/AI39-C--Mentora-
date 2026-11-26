import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

/// Small label + title on the left, optional link on the right.
/// Example: "PERSONALISED FOR YOU / Recommended teachers      Explore all >"
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String eyebrow;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eyebrow.toUpperCase(), style: AppText.eyebrow),
              const SizedBox(height: 4),
              Text(title, style: AppText.sectionTitle),
            ],
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text('$actionLabel ›', style: AppText.link),
          ),
      ],
    );
  }
}