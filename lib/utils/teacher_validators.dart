
class TeacherValidators {
  static String? fullName(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Full name is required';
    if (v.length < 2) return 'Name is too short';
    if (v.length > 60) return 'Name must be under 60 characters';
    if (!RegExp(r"^[A-Za-z][A-Za-z .'-]*$").hasMatch(v)) {
      return 'Use letters only';
    }
    return null;
  }

  /// Accepts 98XXXXXXXX or +977 98XXXXXXXX (also 97...).
  static String? phone(String? value) {
    final v = (value ?? '').replaceAll(RegExp(r'[\s-]'), '');
    if (v.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^(\+977)?9[78]\d{8}$').hasMatch(v)) {
      return 'Enter a valid Nepal number, e.g. +977 98XXXXXXXX';
    }
    return null;
  }

  static String? location(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Location is required';
    if (v.length < 3) return 'Enter your city or district';
    return null;
  }

  static String? qualification(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Qualification is required';
    if (v.length < 2) return 'Qualification is too short';
    if (v.length > 80) return 'Keep it under 80 characters';
    return null;
  }

  /// Whole number of years, 0 to 60.
  static String? experienceYears(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Experience is required';
    final years = int.tryParse(v);
    if (years == null) return 'Enter a whole number';
    if (years < 0 || years > 60) return 'Enter years between 0 and 60';
    return null;
  }

  static String? availability(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Availability is required';
    if (v.length > 60) return 'Keep it under 60 characters';
    return null;
  }

  /// Optional field.
  static String? about(String? value) {
    final v = (value ?? '').trim();
    if (v.length > 400) return 'Keep it under 400 characters';
    return null;
  }

  static String? subjects(Iterable<String> selected) {
    return selected.isEmpty ? 'Select at least one teaching subject' : null;
  }
}
