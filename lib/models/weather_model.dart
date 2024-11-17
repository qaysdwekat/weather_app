import 'package:json_annotation/json_annotation.dart';

import '../features/weather/domain/entities/weather_item.dart';
import 'day_weather_model.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends WeatherItem {
  @override
  final DayWeatherModel? current;
  @override
  final List<DayWeatherModel>? daily;

  const WeatherModel({
    required this.current,
    required this.daily,
  }) : super(
          current: current,
          daily: daily,
        );

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
