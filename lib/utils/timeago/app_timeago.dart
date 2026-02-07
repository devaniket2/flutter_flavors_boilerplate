// ignore_for_file: constant_identifier_names
import 'package:intl/intl.dart'; // For date formatting

final class Timeago {
  Timeago._();

  // string consts that are used for messages or texts
  static const String _JUST_NOW = "just now";
  // ignore: unused_field
  static const String _SECOND = "second";
  static const String _MINUTE = "minute";
  static const String _HOUR = "hour";
  static const String _DAY = "day";
  static const String _WEEK = "week";
  static const String _MONTH = "month";
  static const String _YEAR = "year";
  static const String _CALCULATION_ISSUE = "Unable to count";

  // vars that defines crucial values
  static const int _WEEK_DAYS_COUNT = 7;
  static const int _MONTH_DAYS_COUNT = 30;
  static const int _YEAR_DAYS_COUNT = 365;

  static String getTimeagoByDate(DateTime date) {
    // current datetime to compare with given date
    DateTime now = DateTime.now().toLocal();

    // get difference between given and current time
    Duration difference = now.difference(date);

    return _handleCasesInDuration(difference);
  }

  static String getTimeagoByDuration(Duration duration) =>
      _handleCasesInDuration(duration);

  static String _handleCasesInDuration(Duration difference) {
    // handle differences accordingly
    // (flow -> Bigger durations to Smaller Duartions  )
    // (eg, Years -> Seconds)

    // handle cases starting from a week to a year
    if (difference.inDays > 6) {
      return _handleCasesOverWeeks(difference.inDays);
    }

    // 1 day to 6 days
    if (difference.inDays != 0) return _text(difference.inDays, _DAY);

    // 1 hour to 23 hour
    if (difference.inHours != 0) return _text(difference.inHours, _HOUR);

    // 1 minute to 59 minutes
    if (difference.inMinutes != 0) return _text(difference.inMinutes, _MINUTE);

    // 1 second to 59 seconds
    //if(difference.inSeconds != 0) return _text(difference.inSeconds, _SECOND);

    return _JUST_NOW;
  }

  static String _handleCasesOverWeeks(int days) {
    // logic when duration > 6 days
    // handle cases sucha as weeks (1, 2, 3), months(1 - 11), years(INT.MAX)

    // 1 week to 3 weeks
    if (days >= _WEEK_DAYS_COUNT && days < _MONTH_DAYS_COUNT) {
      int week = days ~/ _WEEK_DAYS_COUNT;
      return week == 4 ? _text(1, _MONTH) : _text(week, _WEEK);
    }

    // 1 month to 11 months
    if (days >= _MONTH_DAYS_COUNT && days < _YEAR_DAYS_COUNT) {
      int month = days ~/ _MONTH_DAYS_COUNT;
      return _text(month, _MONTH);
    }

    // starting from a year
    if (days >= _YEAR_DAYS_COUNT) {
      int year = days ~/ _YEAR_DAYS_COUNT;
      return _text(year, _YEAR);
    }

    return _CALCULATION_ISSUE;
  }

  static String _text(int number, String quantifier) {
    if (number == 1) return '${_prefixText(quantifier)} $quantifier ago';
    return '$number ${quantifier}s ago';
  }

  static String _prefixText(String quantifier) =>
      <String>[_HOUR, _YEAR].contains(quantifier) ? "an" : "a";

  static String getCurrentDateTime(String pattern) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(now);
  }

  static String addHoursToDateTime(String dateTimeString, int hoursToAdd) {
    // Use the correct format for parsing the input
    final DateFormat inputFormatter = DateFormat("MM/dd/yyyy HH:mm:ss");
    final DateFormat outputFormatter = DateFormat("yyyy-MM-dd HH:mm");

    // Parse the input date string
    final DateTime dateTime = inputFormatter.parse(dateTimeString);

    // Add the specified hours
    final DateTime updatedDateTime = dateTime.add(Duration(hours: hoursToAdd));

    // Format and return the updated date-time string
    return outputFormatter.format(updatedDateTime);
  }

  static bool compareDateTimes(String dateTime1, String dateTime2) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm");
    final DateTime dt1 = formatter.parse(dateTime1);
    final DateTime dt2 = formatter.parse(dateTime2);
    return dt2.isAfter(dt1);
  }
}
