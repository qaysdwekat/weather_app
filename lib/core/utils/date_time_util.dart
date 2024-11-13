enum DateTimeType {
  day,
  evening,
  night,
}

class DateTimeUtil {
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
}
