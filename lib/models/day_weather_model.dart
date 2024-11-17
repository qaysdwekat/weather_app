import 'package:json_annotation/json_annotation.dart';

import '../core/utils/date_time_util.dart';
import '../features/weather/domain/entities/day_weather_item.dart';
import 'weather_data_model.dart';

part 'day_weather_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DayWeatherModel extends DayWeatherItem {
  @override
  @JsonKey(name: 'dt', readValue: readDateTimeValue)
  final DateTime? dateTime;
  @override
  @JsonKey(name: 'temp', readValue: readTemperatureValue)
  final double? temperature;

  @override
  final List<WeatherDataModel>? weather;

  const DayWeatherModel({
    required this.dateTime,
    required this.temperature,
    required super.pressure,
    required super.humidity,
    required super.windSpeed,
    required this.weather,
  }) : super(
          weather: weather,
          dateTime: dateTime,
          temperature: temperature,
        );

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

  static Object? readDateTimeValue(Map<dynamic, dynamic> json, String key) {
    final timestamp = json[key];
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return date;
  }

  factory DayWeatherModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DayWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayWeatherModelToJson(this);
}
