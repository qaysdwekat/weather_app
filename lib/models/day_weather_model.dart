import 'package:json_annotation/json_annotation.dart';

import '../core/utils/date_time_util.dart';
import 'weather_data_model.dart';

part 'day_weather_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DayWeatherModel extends DayWeatherItem {
  @JsonKey(name: 'dt')
  final DateTime? dateTime;
  @JsonKey(name: 'temp', readValue: readTemperatureValue)
  final double? temperature;

  final double? pressure;
  final double? humidity;
  final double? windSpeed;
  final List<WeatherItemModel>? weather;

  DayWeatherModel({
    required this.dateTime,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  static Object? readTemperatureValue(Map<dynamic, dynamic> json, String key) {
    if (json[key] is Map<dynamic, dynamic>) {
      final DateTimeType type = DateTimeUtil.getTimeOfDay();
      switch (type) {
        case DateTimeType.day:
          return json[key]['day'];
        case DateTimeType.evening:
          return json[key]['eve'];
        case DateTimeType.night:
          return json[key]['night'];
      }
    }
    return json[key];
  }

  factory DayWeatherModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DayWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayWeatherModelToJson(this);
}
