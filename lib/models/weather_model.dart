import 'package:json_annotation/json_annotation.dart';

import 'day_weather_model.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final DayWeatherModel? current;
  final List<DayWeatherModel>? daily;

  WeatherModel({
    required this.current,
    required this.daily,
  });


  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

}
