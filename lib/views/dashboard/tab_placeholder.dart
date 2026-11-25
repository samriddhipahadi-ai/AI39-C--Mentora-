import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';

/// Temporary page for a tab that is not built yet.
/// Each one is replaced by the real page on Day 3, 4 or 5.
class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Coming soon: $title', style: AppText.body));
  }
}