
import 'package:flutter/material.dart';

import '../../models/student_options.dart';
import '../../models/user_profile.dart';
import '../../services/profile_store.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/student_validators.dart';
import '../widgets/form_field_box.dart';
import '../widgets/section_card.dart';

/// The "Profile information" form shown when a student taps "Edit profile".
class StudentEditForm extends StatefulWidget {
  const StudentEditForm({
    super.key,
    required this.profile,
    required this.onDone,
  });

  final UserProfile profile;

  /// Called after a successful save, so the page can leave edit mode.
  final VoidCallback onDone;

  @override
  State<StudentEditForm> createState() => _StudentEditFormState();
}

class _StudentEditFormState extends State<StudentEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _location;
  late final TextEditingController _school;
  late final TextEditingController _about;

  late String _system;
  late String _classLevel;
  late String _stream;

  late final Set<String> _subjects;

  @override
  void initState() {
    super.initState();

    final p = widget.profile;

    _name = TextEditingController(text: p.name);
    _phone = TextEditingController(text: p.phone);
    _location = TextEditingController(text: p.location);
    _school = TextEditingController(text: p.school);
    _about = TextEditingController(text: p.about);

    _system = StudentOptions.systems.contains(p.educationSystem)
        ? p.educationSystem
        : StudentOptions.systems.first;

    final levels = StudentOptions.classLevels(_system);
    final streams = StudentOptions.streams(_system);

    _classLevel = levels.contains(p.classLevel)
        ? p.classLevel
        : levels.first;

    _stream = streams.contains(p.stream)
        ? p.stream
        : streams.first;

    _subjects = {...p.subjects};
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _phone,
      _location,
      _school,
      _about,
    ]) {
      c.dispose();
    }

    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final subjectError = StudentValidators.subjects(_subjects);

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
        school: _school.text.trim(),
        educationSystem: _system,
        classLevel: _classLevel,
        stream: _stream,
        subjects: _subjects.toList(),
        about: _about.text.trim(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved.')),
    );

    widget.onDone();
  }

  Widget _dropdown(
      String label,
      String value,
      List<String> options,
      ValueChanged<String> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.bodyDark),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            // New key when the value changes, so the field shows the new value.
            key: ValueKey('$label-$value'),
            initialValue: value,
            isExpanded: true,
            items: [
              for (final o in options)
                DropdownMenuItem(
                  value: o,
                  child: Text(o),
                ),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(() => onChanged(v));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectChoices = StudentOptions.subjects(
      _system,
      _stream,
    );

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
              validator: StudentValidators.fullName,
            ),

            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Nepal phone number',
              controller: _phone,
              hint: '+977',
              keyboardType: TextInputType.phone,
              validator: StudentValidators.phone,
            ),

            const SizedBox(height: 16),

            FormFieldBox(
              label: 'Location',
              controller: _location,
              hint: 'City or district',
              validator: StudentValidators.location,
            ),

            const SizedBox(height: 16),

            FormFieldBox(
              label: 'School name',
              controller: _school,
              hint: 'Your school or college',
              validator: StudentValidators.school,
            ),

            const SizedBox(height: 16),

            _dropdown(
              'Education system',
              _system,
              StudentOptions.systems,
                  (v) {
                _system = v;
                _classLevel = StudentOptions.classLevels(v).first;
                _stream = StudentOptions.streams(v).first;
                _subjects.clear();
              },
            ),

            _dropdown(
              'Class level',
              _classLevel,
              StudentOptions.classLevels(_system),
                  (v) => _classLevel = v,
            ),

            _dropdown(
              'Stream',
              _stream,
              StudentOptions.streams(_system),
                  (v) {
                _stream = v;
                _subjects.clear();
              },
            ),

            Text('Subjects', style: AppText.bodyDark),

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
                  for (final subject in subjectChoices)
                    FilterChip(
                      label: Text(
                        subject,
                        style: const TextStyle(fontSize: 11),
                      ),
                      selected: _subjects.contains(subject),
                      onSelected: (yes) => setState(() {
                        yes
                            ? _subjects.add(subject)
                            : _subjects.remove(subject);
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
              validator: StudentValidators.about,
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
                child: Text(
                  'Save profile',
                  style: AppText.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
