import '../models/user_profile.dart';
import '../services/profile_store.dart';

import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';

import '../models/account_role.dart';

import '../main.dart';

import 'widgets/mentora_brand.dart';

import 'widgets/form_field_box.dart';

class AccountRegistrationPage extends StatefulWidget {

  const AccountRegistrationPage({super.key});

  @override

  State<AccountRegistrationPage> createState() => _AccountRegistrationPageState();

}

class _AccountRegistrationPageState extends State<AccountRegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _email = TextEditingController();

  final _phone = TextEditingController();

  final _password = TextEditingController();

  final _qualification = TextEditingController();

  final _experience = TextEditingController();

  final _location = TextEditingController(text: 'Kathmandu, Nepal');

  final _availability = TextEditingController();

  final _bio = TextEditingController();

  final _controller = AuthController();

  AccountRole _role = AccountRole.student;

  String _system = '+2 (NEB)';

  String _classLevel = 'Grade 11';

  String _stream = 'Science';

  final Set<String> _selected = {};

  final Map<String, List<String>> _nebSubjects = {

    'Science': ['Physics','Computer','Biology','Chemistry','Mathematics','Nepali','English'],

    'Management': ['Accounts','Business','Computer Science','Biology','Economics','Nepali','English'],

    'Arts': ['English','Nepali','History','Language','Philosophy'],

    'Law': ['English','Nepali','Social Studies','Procedural Law','Constitutional Law'],

    'Humanities': ['History','Language','Philosophy'],

  };

  final List<String> _teacherSubjects = [

    'Physics','Computer','Biology','Chemistry','Mathematics','Nepali','English',

    'Accounts','Business','Economics','History','Language','Social Studies',

    'Law','Humanities','Science','Exam Preparation',

  ];

  @override

  void dispose() {

    for (final c in [_name,_email,_phone,_password,_qualification,

      _experience,_location,_availability,_bio]) {

      c.dispose();

    }

    super.dispose();

  }

  String? _required(String? value) =>

      (value == null || value.trim().isEmpty) ? 'This field is required' : null;

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) return;

    if (_role == AccountRole.student && _selected.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(content: Text('Please select at least one subject.')));

      return;

    }

    if (_role == AccountRole.teacher && _selected.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(content: Text('Please select at least one teaching area.')));

      return;

    }

    await _controller.createAccount(
        email: _email.text.trim(), password: _password.text, role: _role.label);
    if (!mounted) return;

    // Sprint 2: keep what the person typed so the dashboard can show it.
    // TODO(backend): once real accounts exist, stop here when createAccount fails.
    ProfileStore.instance.signIn(UserProfile(
      role: _role,
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      location: _role == AccountRole.teacher ? _location.text.trim() : '',
      about: _role == AccountRole.teacher ? _bio.text.trim() : '',
      educationSystem: _system,
      classLevel: _classLevel,
      stream: _stream,
      subjects: _selected.toList(),
      qualification: _qualification.text.trim(),
      experienceYears: _experience.text.trim(),
      availability: _availability.text.trim(),
    ));

    // Open the right dashboard and remove the old pages from the back stack.
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        content: Text(_role == AccountRole.student

            ? 'Demo form complete. Connect authentication to create a real account.'

            : 'Could not complete request.')));

  }

  @override

  Widget build(BuildContext context) {

    final subjects = _role == AccountRole.teacher

        ? _teacherSubjects

        : (_system == '+2 (NEB)'

        ? (_nebSubjects[_stream] ?? [])

        : ['Accounts','Business','Computer Science','Economics','History','Language','Philosophy','English']);

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(icon: const Icon(Icons.arrow_back),

            onPressed: () => Navigator.pop(context)),

        title: const MentoraBrand(),

      ),

      body: SafeArea(

        child: Form(

          key: _formKey,

          child: ListView(

            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),

            children: [

              const Text('JOIN MENTORA', style: TextStyle(

                  color: Color(0xFF6E8DA9), fontWeight: FontWeight.bold,

                  letterSpacing: 1.5, fontSize: 11)),

              const SizedBox(height: 10),

              const Text('Create your profile.',

                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.w800,

                      color: MentoraApp.navy)),

              const SizedBox(height: 6),

              const Text('Choose your role and complete your learning profile.',

                  style: TextStyle(color: Colors.black54)),

              const SizedBox(height: 22),

              SegmentedButton<AccountRole>(

                segments: const [

                  ButtonSegment(value: AccountRole.student, label: Text('Student')),

                  ButtonSegment(value: AccountRole.teacher, label: Text('Teacher')),

                ],

                selected: {_role},

                onSelectionChanged: (s) => setState(() {

                  _role = s.first;

                  _selected.clear();

                }),

              ),

              const SizedBox(height: 20),

              FormFieldBox(label: 'Full name', controller: _name,

                  hint: 'Your full name', validator: _required),

              const SizedBox(height: 16),

              FormFieldBox(label: 'Email address', controller: _email,

                  hint: 'you@example.com', keyboardType: TextInputType.emailAddress,

                  validator: (v) {

                    if (v == null || v.trim().isEmpty) return 'Email is required';

                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim())) return 'Enter a valid email';

                    return null;

                  }),

              const SizedBox(height: 16),

              FormFieldBox(label: 'Nepal phone number', controller: _phone,

                  hint: '+977', keyboardType: TextInputType.phone,

                  validator: _required),

              const SizedBox(height: 16),

              FormFieldBox(label: 'Create password', controller: _password,

                  hint: 'At least 8 characters', obscureText: true,

                  validator: (v) => (v == null || v.length < 8)

                      ? 'Password must be at least 8 characters' : null),

              if (_role == AccountRole.student) ...[

                const SizedBox(height: 16),

                _dropdown('Education system', _system,

                    ['+2 (NEB)','A Levels'], (v) {

                      _system = v!;

                      _classLevel = v == '+2 (NEB)' ? 'Grade 11' : 'AS Level';

                      _stream = v == '+2 (NEB)' ? 'Science' : 'Non-science';

                      _selected.clear();

                    }),

                const SizedBox(height: 16),

                _dropdown('Class level', _classLevel,

                    _system == '+2 (NEB)' ? ['Grade 11','Grade 12'] : ['AS Level','A2 Level'],

                        (v) => _classLevel = v!),

                const SizedBox(height: 16),

                _dropdown('Stream', _stream,

                    _system == '+2 (NEB)'

                        ? ['Science','Management','Arts','Law','Humanities']

                        : ['Science','Non-science'],

                        (v) { _stream = v!; _selected.clear(); }),

              ] else ...[

                const SizedBox(height: 16),

                FormFieldBox(label: 'Qualification / certification',

                    controller: _qualification, hint: 'e.g. MSc, Mathematics, B.Ed.',

                    validator: _required),

                const SizedBox(height: 16),

                FormFieldBox(label: 'Teaching experience (years)',

                    controller: _experience, hint: 'e.g. 2',

                    keyboardType: TextInputType.number, validator: _required),

                const SizedBox(height: 16),

                FormFieldBox(label: 'Location', controller: _location,

                    hint: 'City, Country', validator: _required),

                const SizedBox(height: 16),

                FormFieldBox(label: 'Availability', controller: _availability,

                    hint: 'Weekdays or weekends', validator: _required),

                const SizedBox(height: 16),

              ],

              const SizedBox(height: 16),

              Text(_role == AccountRole.student ? 'Subjects' : 'Teaching areas',

                  style: const TextStyle(fontWeight: FontWeight.w600)),

              const SizedBox(height: 8),

              Container(

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(color: Colors.white,

                    border: Border.all(color: const Color(0xFFDCE4EC)),

                    borderRadius: BorderRadius.circular(14)),

                child: Wrap(

                  spacing: 7, runSpacing: 5,

                  children: subjects.map((subject) => FilterChip(

                    label: Text(subject, style: const TextStyle(fontSize: 11)),

                    selected: _selected.contains(subject),

                    onSelected: (yes) => setState(() {

                      yes ? _selected.add(subject) : _selected.remove(subject);

                    }),

                  )).toList(),

                ),

              ),

              if (_role == AccountRole.teacher) ...[

                const SizedBox(height: 16),

                FormFieldBox(label: 'Teaching bio / experience',

                    controller: _bio, hint: 'Write a short introduction',

                    validator: _required),

              ],

              const SizedBox(height: 24),

              SizedBox(height: 54, child: FilledButton(

                style: FilledButton.styleFrom(

                  backgroundColor: MentoraApp.navy,

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),

                ),

                onPressed: _submit,

                child: Text(_role == AccountRole.student

                    ? 'Create student account' : 'Create teacher account',

                    style: const TextStyle(fontWeight: FontWeight.bold)),

              )),

              const SizedBox(height: 14),

              Center(child: TextButton(

                onPressed: () => Navigator.pushReplacementNamed(context, '/sign-in'),

                child: const Text('Already have an account? Sign in'),

              )),

              Center(child: TextButton(

                onPressed: () => Navigator.pushNamed(context, '/forgot-password'),

                child: const Text('Forgot password?'),

              )),

            ],

          ),

        ),

      ),

    );

  }

  Widget _dropdown(String label, String value, List<String> options,

      ValueChanged<String?> changed) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),

      const SizedBox(height: 8),

      DropdownButtonFormField<String>(

        initialValue: value,

        decoration: const InputDecoration(),

        items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),

        onChanged: (v) => setState(() { changed(v); }),

      ),

    ]);

  }

}
