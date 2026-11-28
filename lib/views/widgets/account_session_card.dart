
import 'package:flutter/material.dart';

import '../../services/profile_store.dart';

class AccountSessionCard extends StatelessWidget {
  const AccountSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Stay signed in'),
                ),
                FilledButton(
                  onPressed: () {
                    ProfileStore.instance.signOut();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Log out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
