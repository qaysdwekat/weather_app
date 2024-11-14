import 'package:json_annotation/json_annotation.dart';

import '../features/weather/domain/entities/weather_info_request.dart';
import 'temperature_unit.dart';

part 'weather_info_request_model.g.dart';

@JsonSerializable()
class WeatherInfoRequestModel extends WeatherInfoRequest {
  @override
  @JsonKey(name: 'lat')
  final String? latitude;
  @override
  @JsonKey(name: 'lon')
  final String? longitude;

  const WeatherInfoRequestModel({
    required this.latitude,
    required this.longitude,
    super.exclude = 'minutely,hourly,alerts',
    super.units = TemperatureUnit.standard,
  }) : super(latitude: latitude, longitude: longitude);

  factory WeatherInfoRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoRequestModelToJson(this);

  factory WeatherInfoRequestModel.fromRequest(WeatherInfoRequest request) {
    return WeatherInfoRequestModel(
      latitude: request.latitude,
      longitude: request.longitude,
      exclude: request.exclude,
      units: request.units,
    );
  }
}
