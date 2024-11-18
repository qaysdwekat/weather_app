import 'package:intl/intl.dart';

enum DateTimeType {
  day,
  evening,
  night,
}

class DateTimeFormatConstants {
  static const day = 'EEE';
}

class DateTimeUtil {
  static String getStringFromDate(DateTime dateTime, String format, {String? locale = 'en'}) {
    final dateFormat = DateFormat(format, locale);
    return dateFormat.format(dateTime);
  }

  static DateTimeType getTimeOfDay() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 17) {
      return DateTimeType.day;
    } else if (hour >= 17 && hour < 20) {
      return DateTimeType.evening;
    } else {
      return DateTimeType.night;
    }
  }

  static Object? readDateTimeValue(Map<dynamic, dynamic> json, String key) {
    final timestamp = json[key];
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date.toIso8601String();
  }
}
