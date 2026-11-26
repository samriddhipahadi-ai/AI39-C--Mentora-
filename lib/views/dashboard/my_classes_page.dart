import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_card.dart';
import 'widgets/page_header.dart';

/// Student "My Classes" tab (Figma: "Enrolment status.").
/// [onExplore] opens the Discover tab.
class MyClassesPage extends StatelessWidget {
  const MyClassesPage({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const PageHeader(
          eyebrow: 'My classes',
          title: 'Enrolment status.',
          subtitle:
          'Track the required Admin review and teacher decision before classroom access unlocks.',
          centered: true,
        ),
        SectionCard(
          child: Column(
            children: [
              const EmptyState(
                title: 'No enrolment requests yet',
                message:
                'Explore published classes and request to join the right one for you.',
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                  ),
                  onPressed: onExplore,
                  child: Text('Explore classes', style: AppText.button),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}