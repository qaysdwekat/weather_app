import 'package:json_annotation/json_annotation.dart';

import 'temperature_unit.dart';

part 'weather_info_request.g.dart';

@JsonSerializable()
class WeatherInfoRequest {
  @JsonKey(name: 'lat')
  final String? latitude;
  @JsonKey(name: 'lon')
  final String? longitude;
  final String? exclude;
  final TemperatureUnit? units;

  WeatherInfoRequest({
    required this.latitude,
    required this.longitude,
    this.exclude = 'minutely,hourly,alerts',
    this.units = TemperatureUnit.standard,
  });

  factory WeatherInfoRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoRequestToJson(this);
}
