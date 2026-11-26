
import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/utils/student_validators.dart';

void main() {
  group('fullName', () {
    test('rejects empty text', () {
      expect(StudentValidators.fullName('   '), isNotNull);
    });

    test('rejects digits', () {
      expect(StudentValidators.fullName('Kritima 123'), isNotNull);
    });

    test('accepts a normal name', () {
      expect(StudentValidators.fullName('Kritima Duwadi'), isNull);
    });
  });

  group('phone', () {
    test('accepts a number with +977', () {
      expect(StudentValidators.phone('+977 9705403770'), isNull);
    });

    test('accepts a plain 10 digit number', () {
      expect(StudentValidators.phone('9812345678'), isNull);
    });

    test('rejects a short number', () {
      expect(StudentValidators.phone('12345'), isNotNull);
    });

    test('rejects empty', () {
      expect(StudentValidators.phone(''), isNotNull);
    });
  });

  group('optional fields', () {
    test('location may be empty', () {
      expect(StudentValidators.location(''), isNull);
    });

    test('about has a 300 character limit', () {
      expect(StudentValidators.about('a' * 301), isNotNull);
      expect(StudentValidators.about('a' * 300), isNull);
    });
  });

  test('subjects needs at least one', () {
    expect(StudentValidators.subjects([]), isNotNull);
    expect(StudentValidators.subjects(['Physics']), isNull);
  });
}
