import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/empty_state.dart';
import 'demo_data.dart';
import 'widgets/list_tiles.dart';
import 'widgets/page_header.dart';

/// Student "Discover" tab: search teachers and classes (Figma: "Learn your way.").
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const _allSubjects = 'All subjects';
  static const _subjects = [
    _allSubjects,
    'Chemistry',
    'English',
    'Mathematics',
    'Physics',
  ];

  final _search = TextEditingController();
  String _subject = _allSubjects;
  bool _showTeachers = true;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(String text, String subject) {
    final query = _search.text.trim().toLowerCase();
    final subjectOk = _subject == _allSubjects || _subject == subject;
    final textOk = query.isEmpty || text.toLowerCase().contains(query);
    return subjectOk && textOk;
  }

  Widget _tab(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.navy : AppColors.border,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppText.link
                .copyWith(color: selected ? AppColors.navy : AppColors.label),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teachers = [
      for (final t in demoTeachers)
        if (_matches('${t.name} ${t.qualification}', t.subject)) t,
    ];
    final classes = [
      for (final c in demoClasses)
        if (_matches('${c.title} ${c.detail}', c.subject)) c,
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const PageHeader(
          eyebrow: 'Find the right mentor',
          title: 'Learn your way.',
          subtitle:
          'Discover approved teachers and published classes matched to your education system, stream and subjects.',
          centered: true,
        ),
        TextField(
          controller: _search,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search teachers, classes or subjects',
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _subject,
          isExpanded: true,
          items: [
            for (final s in _subjects) DropdownMenuItem(value: s, child: Text(s)),
          ],
          onChanged: (v) => setState(() => _subject = v ?? _allSubjects),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _tab('Teachers', _showTeachers, () => setState(() => _showTeachers = true)),
            _tab('Classes', !_showTeachers, () => setState(() => _showTeachers = false)),
          ],
        ),
        const SizedBox(height: 16),
        if (_showTeachers) ...[
          if (teachers.isEmpty)
            const EmptyState(
              title: 'No teachers found',
              message: 'Try a different name or subject.',
            )
          else
            for (final t in teachers) TeacherTile(teacher: t),
        ] else ...[
          if (classes.isEmpty)
            const EmptyState(
              title: 'No classes found',
              message: 'Published classes will appear here.',
            )
          else
            for (final c in classes) ClassTile(item: c),
        ],
      ],
    );
  }
}