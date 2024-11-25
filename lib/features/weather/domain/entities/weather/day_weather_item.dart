import 'package:equatable/equatable.dart';

import 'weather_data.dart';

class DayWeatherItem extends Equatable {
  final DateTime? dateTime;
  final double? temperature;
  final double? pressure;
  final double? humidity;
  final double? windSpeed;
  final List<WeatherData>? weather;
  final double? minTemperature;
  final double? maxTemperature;

  final bool isEmpty;

  const DayWeatherItem({
    required this.dateTime,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
    this.maxTemperature,
    this.minTemperature,
    this.isEmpty = false,
  });

  factory DayWeatherItem.empty() => DayWeatherItem(
        dateTime: null,
        temperature: null,
        pressure: null,
        humidity: null,
        windSpeed: null,
        weather: null,
        isEmpty: true,
      );

  @override
  List<Object?> get props => [
        dateTime,
        temperature,
        pressure,
        humidity,
        windSpeed,
        weather,
      ];

  String get iconUrl => weather?.firstOrNull?.iconUrl ?? '';

  String get title => weather?.firstOrNull?.title ?? '';

  String get description => weather?.firstOrNull?.description ?? '';
}
