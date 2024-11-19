import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_item.dart';
import 'package:weather_app/models/weather/temperature_unit.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/weather/day_weather_item.dart';

sealed class WeatherState extends Equatable {
  final WeatherItem? weatherInfo;

  final TemperatureUnit unit;

  String get unitSymbol =>
      unit == TemperatureUnit.metric ? S.current.metric_temperature : S.current.standard_temperature;

  const WeatherState(
    this.weatherInfo, {
    this.unit = TemperatureUnit.metric,
  });

  @override
  List<Object?> get props => [
        weatherInfo,
        unit,
      ];
}

class InitialState extends WeatherState {
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
        );
}

class LoadedState extends WeatherState {
  final WeatherItem data;

  const LoadedState(
    this.data, {
    required super.unit,
  }) : super(data);
}

class ErrorState extends WeatherState {
  final String? error;

  const ErrorState(this.error) : super(null);
}
