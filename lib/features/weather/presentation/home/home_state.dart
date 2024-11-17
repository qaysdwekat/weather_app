import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_item.dart';

import '../../domain/entities/day_weather_item.dart';

class HomeState extends Equatable {
  final WeatherItem? weatherInfo;

  const HomeState(this.weatherInfo);

  factory HomeState.init() => HomeState(WeatherItem(
        current: DayWeatherItem.empty(),
        daily: [
          DayWeatherItem.empty(),
          DayWeatherItem.empty(),
          DayWeatherItem.empty(),
          DayWeatherItem.empty(),
          DayWeatherItem.empty(),
        ],
      ));

  @override
  List<Object?> get props => [
        weatherInfo,
      ];
}
