import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/date_helpers.dart';
import '../widgets/form_field_box.dart';
import '../widgets/section_card.dart';
import 'widgets/page_header.dart';

/// Teacher "Create" tab: the "Create and schedule a class" form.
/// Saving is a demo for now, real storage comes with the backend.
class TeacherCreateClassPage extends StatefulWidget {
  const TeacherCreateClassPage({super.key});

  @override
  State<TeacherCreateClassPage> createState() => _TeacherCreateClassPageState();
}

class _TeacherCreateClassPageState extends State<TeacherCreateClassPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _subject = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _duration = TextEditingController(text: '60');
  final _maxStudents = TextEditingController(text: '20');
  String _type = 'Group';
  String _mode = 'Online';
  DateTime? _when;

  @override
  void dispose() {
    for (final c in [
      _title,
      _subject,
      _description,
      _price,
      _duration,
      _maxStudents,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _required(String? v, String message) =>
      (v == null || v.trim().isEmpty) ? message : null;

  String? _positiveNumber(String? v, String label) {
    final n = int.tryParse((v ?? '').trim());
    if (n == null || n <= 0) return 'Enter a valid $label';
    return null;
  }

  Future<void> _pickDateTime() async {
    final today = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !mounted) return;
    setState(() {
      _when = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_when == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Choose a date and time.')));
      return;
    }
    for (final c in [_title, _subject, _description, _price]) {
      c.clear();
    }
    setState(() => _when = null);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Draft class saved (demo). Storage comes with the backend.'),
    ));
  }

  Widget _dropdown(String label, String value, List<String> options,
      ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.bodyDark),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          items: [
            for (final o in options) DropdownMenuItem(value: o, child: Text(o)),
          ],
          onChanged: (v) {
            if (v != null) setState(() => onChanged(v));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final when = _when;
    final whenText = when == null
        ? 'Choose date and time'
        : '${DateHelpers.longDate(when)} · ${TimeOfDay.fromDateTime(when).format(context)}';

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const PageHeader(
          eyebrow: 'Teaching',
          title: 'Create a class.',
          subtitle: 'Fill in the details and save it as a draft.',
        ),
        Form(
          key: _formKey,
          child: SectionCard(
            title: 'Create and schedule a class',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormFieldBox(
                  label: 'Class title',
                  controller: _title,
                  hint: 'e.g. Grade 12 Physics Revision',
                  validator: (v) => _required(v, 'Class title is required'),
                ),
                const SizedBox(height: 16),
                FormFieldBox(
                  label: 'Subject',
                  controller: _subject,
                  hint: 'e.g. Physics',
                  validator: (v) => _required(v, 'Subject is required'),
                ),
                const SizedBox(height: 16),
                Text('Description', style: AppText.bodyDark),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Learning outcomes, topics and who this class is for...',
                  ),
                ),
                const SizedBox(height: 16),
                _dropdown('Class type', _type, ['Group', 'One-to-one'],
                        (v) => _type = v),
                const SizedBox(height: 16),
                _dropdown('Mode', _mode, ['Online', 'In person'],
                        (v) => _mode = v),
                const SizedBox(height: 16),
                FormFieldBox(
                  label: 'Price (Rs.)',
                  controller: _price,
                  hint: 'e.g. 1200',
                  keyboardType: TextInputType.number,
                  validator: (v) => _positiveNumber(v, 'price'),
                ),
                const SizedBox(height: 16),
                FormFieldBox(
                  label: 'Duration (minutes)',
                  controller: _duration,
                  hint: 'e.g. 60',
                  keyboardType: TextInputType.number,
                  validator: (v) => _positiveNumber(v, 'duration'),
                ),
                const SizedBox(height: 16),
                FormFieldBox(
                  label: 'Maximum students',
                  controller: _maxStudents,
                  hint: 'e.g. 20',
                  keyboardType: TextInputType.number,
                  validator: (v) => _positiveNumber(v, 'number of students'),
                ),
                const SizedBox(height: 16),
                Text('Date and time', style: AppText.bodyDark),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.navy,
                      alignment: Alignment.centerLeft,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                    ),
                    onPressed: _pickDateTime,
                    icon: const Icon(Icons.calendar_today_outlined, size: 18),
                    label: Text(whenText),
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
                          borderRadius: BorderRadius.circular(13)),
                    ),
                    onPressed: _submit,
                    child: Text('Create draft class', style: AppText.button),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}