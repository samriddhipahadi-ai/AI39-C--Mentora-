import 'package:flutter/material.dart';

import '../../services/profile_store.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/date_helpers.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_card.dart';
import 'demo_data.dart';
import 'widgets/calendar_card.dart';
import 'widgets/list_tiles.dart';
import 'widgets/mentora_banner.dart';
import 'widgets/section_header.dart';
import 'widgets/stat_card.dart';

/// Student "Home" tab (Figma: "Good evening, ...").
/// [onGoTo] switches the bottom navigation tab: 1 = Discover, 2 = My Classes.
class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key, required this.onGoTo});

  final ValueChanged<int> onGoTo;

  /// Two stat cards side by side, both the same height.
  Widget _statRow(Widget left, Widget right) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: left),
            const SizedBox(width: 12),
            Expanded(child: right),
          ],
        ),
      ),
    );
  }

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
            const SizedBox(height: 8),
            Text('Your classes, notes and teachers are all ready in one place.',
                style: AppText.body),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
                onPressed: () => onGoTo(2),
                icon: const Icon(Icons.school_outlined, size: 18),
                label: Text('Continue learning', style: AppText.button),
              ),
            ),
            const SizedBox(height: 16),
            _statRow(
              const StatCard(
                icon: Icons.school_outlined,
                label: 'Enrolled classes',
                value: '0',
                caption: 'Managed by Mentora Admin',
              ),
              const StatCard(
                icon: Icons.person_outline,
                label: 'Class notes',
                value: '0',
                caption: 'Shared by your teachers',
              ),
            ),
            _statRow(
              const StatCard(
                icon: Icons.calendar_today_outlined,
                label: 'Live meetings',
                value: '0',
                caption: 'No active room',
              ),
              const StatCard(
                icon: Icons.chat_bubble_outline,
                label: 'Messages',
                value: '0',
                caption: 'Private student-teacher chat',
              ),
            ),
            const SizedBox(height: 4),
            MentoraBanner(
              chip: 'Student space',
              title: 'Learn better, together.',
              message:
              'Mentora connects students and teachers directly for focused, personal learning.',
              buttonLabel: 'View approved pricing',
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Pricing will be added in a later sprint.')),
              ),
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
                        onPressed: () => onGoTo(2),
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
            SectionHeader(
              eyebrow: 'Personalised for you',
              title: 'Recommended teachers',
              actionLabel: 'Explore all',
              onAction: () => onGoTo(1),
            ),
            const SizedBox(height: 10),
            for (final teacher in demoTeachers) TeacherTile(teacher: teacher),
            const SizedBox(height: 14),
            SectionHeader(
              eyebrow: 'Based on your subjects',
              title: 'Classes you may like',
              actionLabel: 'View catalogue',
              onAction: () => onGoTo(1),
            ),
            const SizedBox(height: 10),
            for (final item in demoClasses) ClassTile(item: item),
          ],
        );
      },
    );
  }
}