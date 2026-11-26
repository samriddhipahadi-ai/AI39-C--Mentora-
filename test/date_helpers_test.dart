import 'package:flutter_test/flutter_test.dart';
import 'package:mentora/utils/date_helpers.dart';

void main() {
  test('longDate formats like the Figma header', () {
    expect(DateHelpers.longDate(DateTime(2026, 11, 22)), 'Sunday, November 22');
  });

  test('greeting changes through the day', () {
    expect(DateHelpers.greeting(DateTime(2026, 11, 22, 8)), 'Good morning');
    expect(DateHelpers.greeting(DateTime(2026, 11, 22, 14)), 'Good afternoon');
    expect(DateHelpers.greeting(DateTime(2026, 11, 22, 21)), 'Good evening');
  });

  test('week starts on Sunday', () {
    // 25 November 2026 is a Wednesday, so the week runs 22 to 28 November.
    final week = DateHelpers.weekFrom(DateTime(2026, 11, 25));
    expect(week.length, 7);
    expect(week.first.day, 22);
    expect(week.last.day, 28);
  });

  test('week that crosses a month end', () {
    // 2 December 2026 is a Wednesday, so the week starts on 29 November.
    final week = DateHelpers.weekFrom(DateTime(2026, 12, 2));
    expect(week.first, DateTime(2026, 11, 29));
    expect(week.last, DateTime(2026, 12, 5));
  });
}