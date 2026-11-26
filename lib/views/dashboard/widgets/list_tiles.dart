import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../demo_data.dart';

/// One row in "Recommended teachers": initial box, name, qualification, rating.
class TeacherTile extends StatelessWidget {
  const TeacherTile({super.key, required this.teacher});

  final DemoTeacher teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              teacher.name.substring(0, 1).toUpperCase(),
              style: AppText.sectionTitle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teacher.name,
                    style: AppText.cardTitle.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(teacher.qualification, style: AppText.small),
                const SizedBox(height: 2),
                Text(teacher.detail,
                    style: AppText.small.copyWith(color: AppColors.accent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One row in "Classes you may like".
class ClassTile extends StatelessWidget {
  const ClassTile({super.key, required this.item});

  final DemoClass item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.subject.toUpperCase(), style: AppText.eyebrow),
          const SizedBox(height: 4),
          Text(item.title, style: AppText.cardTitle.copyWith(fontSize: 15)),
          const SizedBox(height: 2),
          Text(item.detail, style: AppText.small),
        ],
      ),
    );
  }
}