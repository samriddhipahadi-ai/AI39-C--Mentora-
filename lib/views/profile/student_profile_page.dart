
import 'package:flutter/material.dart';

import '../../services/profile_store.dart';
import '../widgets/account_session_card.dart';
import '../widgets/info_tile.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/section_card.dart';
import 'student_edit_form.dart';

/// Student profile page with view and edit modes.
class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() =>
      _StudentProfilePageState();
}

class _StudentProfilePageState
    extends State<StudentProfilePage> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProfileStore.instance,
      builder: (context, _) {
        final profile = ProfileStore.instance.current;

        if (profile == null) {
          return const SizedBox.shrink();
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            ProfileHeaderCard(
              profile: profile,
              subtitle: profile.studentSummary,
              editing: _editing,
              onToggleEdit: () {
                setState(() {
                  _editing = !_editing;
                });
              },
            ),

            if (_editing)
              StudentEditForm(
                profile: profile,
                onDone: () =>
                    setState(() => _editing = false),
              )
            else ...[
              SectionCard(
                title: 'Login & contact information',
                subtitle:
                'Add a short introduction to help your Mentora connections know you better.',
                child: Column(
                  children: [
                    InfoTile(
                      label: 'Name',
                      value: profile.name,
                    ),
                    InfoTile(
                      label: 'Email',
                      value: profile.email,
                    ),
                    InfoTile(
                      label: 'Phone',
                      value: profile.phone,
                    ),
                    InfoTile(
                      label: 'Location',
                      value: profile.location,
                    ),
                  ],
                ),
              ),

              SectionCard(
                title: 'Student profile',
                child: Column(
                  children: [
                    InfoTile(
                      label: 'Class',
                      value: profile.classLevel,
                    ),
                    InfoTile(
                      label: 'School',
                      value: profile.school,
                    ),
                    InfoTile(
                      label: 'Education',
                      value: profile.educationSystem,
                    ),
                    InfoTile(
                      label: 'Stream',
                      value: profile.stream,
                    ),
                    InfoTile(
                      label: 'Subjects',
                      value: profile.subjects.join(', '),
                    ),
                    InfoTile(
                      label: 'About',
                      value: profile.about,
                    ),
                  ],
                ),
              ),
            ],

            const AccountSessionCard(),
          ],
        );
      },
    );
  }
}
