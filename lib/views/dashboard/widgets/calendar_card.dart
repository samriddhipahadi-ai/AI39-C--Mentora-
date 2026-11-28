import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/date_helpers.dart';
import '../../widgets/section_card.dart';

/// "November 22  [Today]" with the week row and today highlighted.
class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key, required this.today});

  final DateTime today;

  static const _initials = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    final week = DateHelpers.weekFrom(today);

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${DateHelpers.month(today)} ',
                      style: AppText.cardTitle,
                    ),
                    TextSpan(
                      text: '${today.day}',
                      style: AppText.sectionTitle
                          .copyWith(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Today', style: AppText.chip),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: _DayCell(
                    initial: _initials[i],
                    date: week[i],
                    isToday: week[i].year == today.year &&
                        week[i].month == today.month &&
                        week[i].day == today.day,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          // Left accent line + grey box. IntrinsicHeight makes the line as tall as the box.
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 3, color: AppColors.accent),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: AppColors.pale,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Synced daily', style: AppText.small),
                        const SizedBox(height: 2),
                        Text(DateHelpers.longDate(today),
                            style: AppText.bodyDark),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.initial,
    required this.date,
    required this.isToday,
  });

  final String initial;
  final DateTime date;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(initial, style: AppText.small),
        const SizedBox(height: 6),
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isToday ? AppColors.navy : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '${date.day}',
            style: AppText.bodyDark
                .copyWith(color: isToday ? Colors.white : AppColors.navy),
          ),
        ),
      ],
    );
  }
}