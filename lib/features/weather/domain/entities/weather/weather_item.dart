import 'package:equatable/equatable.dart';

import 'day_weather_item.dart';

class WeatherItem extends Equatable {
  final DayWeatherItem? current;
  final List<DayWeatherItem>? daily;

  const WeatherItem({
    required this.current,
    required this.daily,
  });

  @override
  List<Object?> get props => [
        current,
        daily,
      ];
}
