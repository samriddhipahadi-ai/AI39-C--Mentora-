import 'package:flutter/material.dart';

<<<<<<< HEAD
=======
import 'section_card.dart';

/// PLACEHOLDER. Samriddhi replaces this whole file on Day 3 (story 2.4 Logout).
/// Keep the name and `const AccountSessionCard()` so both profile pages keep working.
>>>>>>> origin/tanu
class AccountSessionCard extends StatelessWidget {
  const AccountSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: const Text('Log out'),
        subtitle: const Text('Sign out of your account'),
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Log out?'),
              content: const Text(
                'Are you sure you want to log out?',
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () =>
                      Navigator.pop(dialogContext),
                  child: const Text('Log out'),
                ),
              ],
            ),
          );
        },
=======
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
>>>>>>> origin/tanu
      ),
    );
  }
}