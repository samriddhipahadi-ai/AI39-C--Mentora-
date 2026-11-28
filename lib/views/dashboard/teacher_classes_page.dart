import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_card.dart';
import 'widgets/page_header.dart';

/// Teacher "Classes" tab (Figma: "Classes & notes.").
/// [onNewClass] opens the Create tab.
class TeacherClassesPage extends StatelessWidget {
  const TeacherClassesPage({super.key, required this.onNewClass});

  final VoidCallback onNewClass;

  void _later(BuildContext context, String what) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$what will be added in a later sprint.')),
    );
  }

  Widget _outlined(BuildContext context, String label, IconData icon) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy,
          side: const BorderSide(color: AppColors.border),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => _later(context, label),
        icon: Icon(icon, size: 18),
        label: Text(label, style: AppText.button),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const PageHeader(
          eyebrow: 'Teaching',
          title: 'Classes & notes.',
          subtitle:
          'Create and schedule classes, see every enrolled student and share notes.',
        ),
        _outlined(context, 'Material', Icons.add),
        const SizedBox(height: 10),
        _outlined(context, 'Note', Icons.add),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.navy,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onNewClass,
            icon: const Icon(Icons.add, size: 18),
            label: Text('New class', style: AppText.button),
          ),
        ),
        const SizedBox(height: 16),
        const SectionCard(
          child: EmptyState(
            title: 'No classes assigned',
            message:
            'Ask Mentora Admin to enrol you or assign you as the teacher of a class.',
          ),
        ),
        const SectionCard(
          eyebrow: 'Shared resources',
          title: 'Class notes',
          child: EmptyState(
            title: 'No notes yet',
            message: 'Add the first note for one of your classes.',
          ),
        ),
      ],
    );
  }
}