import 'package:flutter/material.dart';

/// Asks "Are you sure?" before logging out.
/// Returns true only when the person taps "Log out".
Future<bool> showLogoutConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Log out?'),
      content: const Text('You will need to sign in again to see your dashboard.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Stay signed in'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Log out'),
        ),
      ],
    ),
  );
  return result ?? false;
}
