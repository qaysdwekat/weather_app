import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_item.dart';
import 'package:weather_app/models/temperature_unit.dart';

import '../../domain/entities/day_weather_item.dart';

sealed class HomeState extends Equatable {
  final WeatherItem? weatherInfo;

  final TemperatureUnit unti;

  const HomeState(
    this.weatherInfo, {
    this.unti = TemperatureUnit.metric,
  });

  @override
  List<Object?> get props => [
        weatherInfo,
        unti,
      ];
}

class InitialState extends HomeState {
  InitialState()
      : super(WeatherItem(
          current: DayWeatherItem.empty(),
          daily: [
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
          ],
        ));
}

class LoadingState extends HomeState {
  LoadingState()
      : super(WeatherItem(
          current: DayWeatherItem.empty(),
          daily: [
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
            DayWeatherItem.empty(),
          ],
        ));
}

class LoadedState extends HomeState {
  final WeatherItem data;

  const LoadedState(this.data) : super(data);
}

class ErrorState extends HomeState {
  final String? error;

  const ErrorState(this.error) : super(null);
}
