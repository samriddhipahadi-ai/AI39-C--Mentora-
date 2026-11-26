
import 'package:flutter/material.dart';

import '../../services/profile_store.dart';
import '../widgets/account_session_card.dart';
import '../widgets/info_tile.dart';
import '../widgets/section_card.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

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
            SectionCard(
              title: profile.name,
              subtitle: 'Teacher profile',
              child: Column(
                children: [
                  InfoTile(label: 'Email', value: profile.email),
                  InfoTile(label: 'Phone', value: profile.phone),
                  InfoTile(label: 'Location', value: profile.location),
                  InfoTile(
                    label: 'Qualification',
                    value: profile.qualification,
                  ),
                  InfoTile(
                    label: 'Experience',
                    value: '${profile.experienceYears} years',
                  ),
                  InfoTile(
                    label: 'Availability',
                    value: profile.availability,
                  ),
                ],
              ),
            ),
            const AccountSessionCard(),
          ],
        );
      },
    );
  }
}
