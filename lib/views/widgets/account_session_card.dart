import 'package:flutter/material.dart';

import 'section_card.dart';

/// PLACEHOLDER. Samriddhi replaces this whole file on Day 3 (story 2.4 Logout).
/// Keep the name and `const AccountSessionCard()` so both profile pages keep working.
class AccountSessionCard extends StatelessWidget {
  const AccountSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Account session',
      subtitle: 'Sign out securely from this device.',
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          onPressed: () {},
          child: const Text('Log out'),
        ),
      ),
    );
  }
}