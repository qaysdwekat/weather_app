import 'package:equatable/equatable.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/weather/temperature_unit.dart';
import '../../domain/entities/weather/day_weather_item.dart';
import '../../domain/entities/weather/weather_item.dart';

sealed class WeatherState extends Equatable {
  final WeatherItem? weatherInfo;

  final DayWeatherItem? current;

  final TemperatureUnit unit;

  String get unitSymbol =>
      unit == TemperatureUnit.metric ? S.current.metric_temperature : S.current.standard_temperature;

  const WeatherState(
    this.weatherInfo, {
    this.current,
    this.unit = TemperatureUnit.metric,
  });

  @override
  List<Object?> get props => [
        weatherInfo,
        unit,
        current,
      ];
}

class InitialState extends WeatherState {
  InitialState()
      : super(
          WeatherItem(
            current: DayWeatherItem.empty(),
            daily: [
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
            ],
          ),
          current: DayWeatherItem.empty(),
        );
}

class LoadingState extends WeatherState {
  LoadingState({super.unit})
      : super(
          WeatherItem(
            current: DayWeatherItem.empty(),
            daily: [
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
              DayWeatherItem.empty(),
            ],
          ),
          current: DayWeatherItem.empty(),
        );
}

class LoadedState extends WeatherState {
  final WeatherItem data;

  const LoadedState(
    this.data, {
    required super.unit,
    super.current,
  }) : super(
          data,
        );
}

class LoadedCurrentWeatherState extends WeatherState {
  const LoadedCurrentWeatherState(
    super.weatherInfo, {
    super.unit,
    super.current,
  });
}

class ErrorState extends WeatherState {
  final String? error;

  const ErrorState(this.error) : super(null);
}
