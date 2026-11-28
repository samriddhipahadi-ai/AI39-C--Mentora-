import 'package:flutter/material.dart';
import '../../services/profile_store.dart';
import '../widgets/account_session_card.dart';
import '../widgets/info_tile.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/section_card.dart';
import 'teacher_edit_form.dart';

/// Teacher profile page with view and edit modes.
class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    // Rebuilds by itself whenever the profile changes in ProfileStore.
    return ListenableBuilder(
      listenable: ProfileStore.instance,
      builder: (context, _) {
        final profile = ProfileStore.instance.current;

        if (profile == null) return const SizedBox.shrink();

        final experience = profile.experienceYears.trim().isEmpty
            ? ''
            : '${profile.experienceYears.trim()} years';

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            ProfileHeaderCard(
              profile: profile,
              subtitle: 'Mentora educator profile',
              editing: _editing,
              onToggleEdit: () => setState(() => _editing = !_editing),
            ),

            if (_editing)
              TeacherEditForm(
                profile: profile,
                onDone: () => setState(() => _editing = false),
              )
            else ...[
              SectionCard(
                title: 'Login & contact information',
                subtitle:
                'Add a short introduction to help your Mentora connections know you better.',
                child: Column(
                  children: [
                    InfoTile(label: 'Name', value: profile.name),
                    InfoTile(label: 'Email', value: profile.email),
                    InfoTile(label: 'Phone', value: profile.phone),
                    InfoTile(label: 'Location', value: profile.location),
                  ],
                ),
              ),

              SectionCard(
                title: 'Teacher profile',
                child: Column(
                  children: [
                    InfoTile(
                      label: 'Eligibility / qualification',
                      value: profile.qualification,
                    ),
                    InfoTile(
                      label: 'Experience',
                      value: experience,
                    ),
                    InfoTile(
                      label: 'Availability',
                      value: profile.availability,
                    ),
                    InfoTile(
                      label: 'Teaching subjects',
                      value: profile.subjects.join(', '),
                    ),
                    InfoTile(
                      label: 'Bio',
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