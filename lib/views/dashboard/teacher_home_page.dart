import 'package:flutter/material.dart';

import '../../services/profile_store.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/date_helpers.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_card.dart';
import 'widgets/calendar_card.dart';
import 'widgets/mentora_banner.dart';

/// Teacher "Home" tab (Figma: "Continue teaching.").
/// [onGoTo] switches the bottom navigation tab: 1 = Classes.
class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key, required this.onGoTo});

  final ValueChanged<int> onGoTo;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProfileStore.instance,
      builder: (context, _) {
        final profile = ProfileStore.instance.current;
        if (profile == null) return const SizedBox.shrink();

        final now = DateTime.now();
        final name = profile.name.trim();
        final firstName = name.isEmpty ? 'there' : name.split(' ').first;

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Text(DateHelpers.longDate(now).toUpperCase(), style: AppText.eyebrow),
            const SizedBox(height: 8),
            Text('${DateHelpers.greeting(now)}, $firstName.',
                style: AppText.greeting),
            const SizedBox(height: 16),
            MentoraBanner(
              chip: 'Teacher space',
              title: 'Continue teaching.',
              message:
              'Schedule classes, support enrolled students and bring your next lesson live.',
              buttonLabel: 'Continue teaching',
              onPressed: () => onGoTo(1),
            ),
            SectionCard(
              eyebrow: 'Your space',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('No classes assigned yet',
                            style: AppText.sectionTitle),
                      ),
                      TextButton(
                        onPressed: () => onGoTo(1),
                        child: Text('Open learning ›', style: AppText.link),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const EmptyState(
                    title: 'Your class list is ready for enrolment',
                    message:
                    'Mentora Admin assigns teachers and students to approved classes.',
                  ),
                ],
              ),
            ),
            CalendarCard(today: now),
            SectionCard(
              title: 'Latest notes',
              child: Text('Teacher notes will appear here.', style: AppText.body),
            ),
          ],
        );
      },
    );
  }
}