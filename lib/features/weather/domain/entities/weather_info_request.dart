import 'package:equatable/equatable.dart';

import '../../../../models/temperature_unit.dart';

class WeatherInfoRequest extends Equatable {
  final String? latitude;
  final String? longitude;
  final String? exclude;
  final TemperatureUnit? units;

  const WeatherInfoRequest({
    required this.latitude,
    required this.longitude,
    this.exclude = 'minutely,hourly,alerts',
    this.units = TemperatureUnit.standard,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        exclude,
        units,
      ];
}
