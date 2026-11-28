import 'package:flutter/material.dart';

class MentoraBrand extends StatelessWidget {
  const MentoraBrand({super.key, this.dark = false});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final color = dark ? Colors.white : const Color(0xFF203A56);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.school_rounded, color: color, size: 29),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MENTORA',
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
            Text(
              'Find the right mentor. Learn your way.',
              style: TextStyle(
                color: color.withValues(alpha: 0.75),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
