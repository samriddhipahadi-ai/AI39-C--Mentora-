import 'dart:typed_data';

import 'account_role.dart';

/// Everything the app knows about one user (a student or a teacher).
class UserProfile {
  const UserProfile({
    required this.role,
    required this.name,
    required this.email,
    this.phone = '',
    this.location = '',
    this.about = '',
    this.photoBytes,
    // Student fields
    this.school = '',
    this.educationSystem = '+2 (NEB)',
    this.classLevel = 'Grade 11',
    this.stream = 'Science',
    // Student subjects, or a teacher's teaching subjects
    this.subjects = const [],
    // Teacher fields
    this.qualification = '',
    this.experienceYears = '',
    this.availability = '',
  });

  final AccountRole role;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String about;
  final Uint8List? photoBytes;

  final String school;
  final String educationSystem;
  final String classLevel;
  final String stream;
  final List<String> subjects;

  final String qualification;
  final String experienceYears;
  final String availability;

  bool get isTeacher => role == AccountRole.teacher;

  /// First letter of the name, shown when there is no photo.
  String get initial => name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();

  /// Line under the name on a student profile, e.g. "A Levels · A2 Level · Science".
  String get studentSummary => '$educationSystem · $classLevel · $stream';

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? about,
    Uint8List? photoBytes,
    String? school,
    String? educationSystem,
    String? classLevel,
    String? stream,
    List<String>? subjects,
    String? qualification,
    String? experienceYears,
    String? availability,
  }) {
    return UserProfile(
      role: role,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      about: about ?? this.about,
      photoBytes: photoBytes ?? this.photoBytes,
      school: school ?? this.school,
      educationSystem: educationSystem ?? this.educationSystem,
      classLevel: classLevel ?? this.classLevel,
      stream: stream ?? this.stream,
      subjects: subjects ?? this.subjects,
      qualification: qualification ?? this.qualification,
      experienceYears: experienceYears ?? this.experienceYears,
      availability: availability ?? this.availability,
    );
  }
}