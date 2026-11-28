/// Small date helpers, so we do not need the `intl` package.
class DateHelpers {
  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String weekday(DateTime d) => _weekdays[d.weekday - 1];

  static String month(DateTime d) => _months[d.month - 1];

  /// Example: "Sunday, November 22".
  static String longDate(DateTime d) => '${weekday(d)}, ${month(d)} ${d.day}';

  /// "Good morning", "Good afternoon" or "Good evening".
  static String greeting(DateTime d) {
    if (d.hour < 12) return 'Good morning';
    if (d.hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// The 7 days of the week that contains [d], starting on Sunday.
  static List<DateTime> weekFrom(DateTime d) {
    // DateTime.weekday: Monday = 1 ... Sunday = 7. Sunday % 7 = 0.
    final daysSinceSunday = d.weekday % 7;
    return List.generate(
      7,
          (i) => DateTime(d.year, d.month, d.day - daysSinceSunday + i),
    );
  }
}