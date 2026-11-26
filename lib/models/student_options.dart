
/// Choices shown in the student profile form.
/// They match the registration page.
class StudentOptions {
  static const systems = ['+2 (NEB)', 'A Levels'];

  static const _nebSubjects = {
    'Science': [
      'Physics',
      'Computer',
      'Biology',
      'Chemistry',
      'Mathematics',
      'Nepali',
      'English',
    ],
    'Management': [
      'Accounts',
      'Business',
      'Computer Science',
      'Biology',
      'Economics',
      'Nepali',
      'English',
    ],
    'Arts': ['English', 'Nepali', 'History', 'Language', 'Philosophy'],
    'Law': [
      'English',
      'Nepali',
      'Social Studies',
      'Procedural Law',
      'Constitutional Law',
    ],
    'Humanities': ['History', 'Language', 'Philosophy'],
  };

  static const _aLevelScience = [
    'Physics',
    'Computer',
    'Biology',
    'Chemistry',
    'Mathematics',
    'Nepali',
    'English',
  ];

  static const _aLevelNonScience = [
    'Accounts',
    'Business',
    'Computer Science',
    'Economics',
    'History',
    'Language',
    'Philosophy',
    'English',
  ];

  static List<String> classLevels(String system) =>
      system == '+2 (NEB)' ? ['Grade 11', 'Grade 12'] : ['AS Level', 'A2 Level'];

  static List<String> streams(String system) => system == '+2 (NEB)'
      ? ['Science', 'Management', 'Arts', 'Law', 'Humanities']
      : ['Science', 'Non-science'];

  static List<String> subjects(String system, String stream) {
    if (system == '+2 (NEB)') return _nebSubjects[stream] ?? [];
    return stream == 'Science' ? _aLevelScience : _aLevelNonScience;
  }
}
