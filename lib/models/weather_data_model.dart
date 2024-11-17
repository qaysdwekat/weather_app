import 'package:json_annotation/json_annotation.dart';

import '../features/weather/domain/entities/weather_data.dart';

part 'weather_data_model.g.dart';

@JsonSerializable()
class WeatherDataModel extends WeatherData {
  @override
  @JsonKey(name: 'main')
  final String? title;

  const WeatherDataModel({
    this.title,
    required super.description,
    required super.icon,
  }) : super(title: title);

  factory WeatherDataModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataModelToJson(this);
}
