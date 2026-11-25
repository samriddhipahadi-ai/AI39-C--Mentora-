import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/utils/teacher_validators.dart';

void main() {
  group('experienceYears', () {
    test('accepts 5', () => expect(TeacherValidators.experienceYears('5'), isNull));
    test('rejects text', () {
      expect(TeacherValidators.experienceYears('five'), isNotNull);
    });
    test('rejects negative', () {
      expect(TeacherValidators.experienceYears('-1'), isNotNull);
    });
    test('rejects 61', () {
      expect(TeacherValidators.experienceYears('61'), isNotNull);
    });
    test('rejects empty', () {
      expect(TeacherValidators.experienceYears(' '), isNotNull);
    });
  });

  group('qualification and availability', () {
    test('qualification is required', () {
      expect(TeacherValidators.qualification(''), isNotNull);
      expect(TeacherValidators.qualification('MSc Mathematics'), isNull);
    });
    test('availability is required', () {
      expect(TeacherValidators.availability(''), isNotNull);
      expect(TeacherValidators.availability('Weekdays after 4pm'), isNull);
    });
  });

  group('phone', () {
    test('accepts +977 number', () {
      expect(TeacherValidators.phone('+977 9705403770'), isNull);
    });
    test('rejects letters', () {
      expect(TeacherValidators.phone('98abc12345'), isNotNull);
    });
  });

  test('about has a 400 character limit', () {
    expect(TeacherValidators.about('a' * 401), isNotNull);
    expect(TeacherValidators.about('a' * 400), isNull);
  });

  test('subjects needs at least one', () {
    expect(TeacherValidators.subjects([]), isNotNull);
    expect(TeacherValidators.subjects(['Physics']), isNull);
  });
}
