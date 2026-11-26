import 'package:flutter/material.dart';
import '../../models/teacher_options.dart';
import '../../models/user_profile.dart';
import '../../services/profile_store.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/teacher_validators.dart';
import '../widgets/form_field_box.dart';
import '../widgets/section_card.dart';

/// The "Profile information" form shown when a teacher taps "Edit profile".
class TeacherEditForm extends StatefulWidget {
  const TeacherEditForm({
    super.key,
    required this.profile,
    required this.onDone,
  });

  final UserProfile profile;

  /// Called after a successful save, so the page can leave edit mode.
  final VoidCallback onDone;

  @override
  State<TeacherEditForm> createState() => _TeacherEditFormState();
}

class _TeacherEditFormState extends State<TeacherEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _location;
  late final TextEditingController _qualification;
  late final TextEditingController _experience;
  late final TextEditingController _availability;
  late final TextEditingController _about;

  late final Set<String> _subjects;

  @override
  void initState() {
    super.initState();

    final p = widget.profile;

    _name = TextEditingController(text: p.name);
    _phone = TextEditingController(text: p.phone);
    _location = TextEditingController(text: p.location);
    _qualification = TextEditingController(text: p.qualification);
    _experience = TextEditingController(text: p.experienceYears);
    _availability = TextEditingController(text: p.availability);
    _about = TextEditingController(text: p.about);

    _subjects = {...p.subjects};
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _phone,
      _location,
      _qualification,
      _experience,
      _availability,
      _about,
    ]) {
      c.dispose();
    }

    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final subjectError = TeacherValidators.subjects(_subjects);

    if (subjectError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(subjectError)),
      );
      return;
    }

    // Start from the newest saved profile so a photo picked meanwhile is kept.
    final store = ProfileStore.instance;
    final base = store.current ?? widget.profile;

    store.update(
      base.copyWith(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        location: _location.text.trim(),
        qualification: _qualification.text.trim(),
        experienceYears: _experience.text.trim(),
        availability: _availability.text.trim(),
        subjects: _subjects.toList(),
        about: _about.text.trim(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved.')),
    );

    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SectionCard(
        title: 'Profile information',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormFieldBox(
              label: 'Full name',
              controller: _name,
              hint: 'Your full name',
              validator: TeacherValidators.fullName,
            ),
            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Nepal phone number',
              controller: _phone,
              hint: '+977',
              keyboardType: TextInputType.phone,
              validator: TeacherValidators.phone,
            ),
            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Location',
              controller: _location,
              hint: 'City or district',
              validator: TeacherValidators.location,
            ),
            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Eligibility / qualification',
              controller: _qualification,
              hint: 'e.g. MSc Mathematics, B.Ed.',
              validator: TeacherValidators.qualification,
            ),
            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Experience (years)',
              controller: _experience,
              hint: 'e.g. 5',
              keyboardType: TextInputType.number,
              validator: TeacherValidators.experienceYears,
            ),
            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Availability',
              controller: _availability,
              hint: 'Weekdays or weekends',
              validator: TeacherValidators.availability,
            ),
            const SizedBox(height: 16),

            Text('Teaching subjects', style: AppText.bodyDark),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Wrap(
                spacing: 7,
                runSpacing: 5,
                children: [
                  for (final subject in TeacherOptions.subjects)
                    FilterChip(
                      label: Text(
                        subject,
                        style: const TextStyle(fontSize: 11),
                      ),
                      selected: _subjects.contains(subject),
                      onSelected: (yes) => setState(() {
                        yes ? _subjects.add(subject) : _subjects.remove(subject);
                      }),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text('About you', style: AppText.bodyDark),
            const SizedBox(height: 8),

            TextFormField(
              controller: _about,
              maxLines: 4,
              validator: TeacherValidators.about,
              decoration: const InputDecoration(
                hintText: 'Share a short introduction...',
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: _save,
                child: Text('Save profile', style: AppText.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}