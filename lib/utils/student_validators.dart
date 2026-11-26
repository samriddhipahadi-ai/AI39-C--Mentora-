
/// Form checks for the student profile (story 2.1, Validation).
/// Every method returns an error message, or null when the value is fine.
class StudentValidators {
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

  /// Optional field.
  static String? location(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return null;
    if (v.length < 3) return 'Enter your city or district';
    return null;
  }

  /// Optional field.
  static String? school(String? value) {
    final v = (value ?? '').trim();
    if (v.length > 80) return 'School name must be under 80 characters';
    return null;
  }

  /// Optional field.
  static String? about(String? value) {
    final v = (value ?? '').trim();
    if (v.length > 300) return 'Keep it under 300 characters';
    return null;
  }

  static String? subjects(Iterable<String> selected) {
    return selected.isEmpty ? 'Select at least one subject' : null;
  }
}
