import 'package:json_annotation/json_annotation.dart';

part 'weather_item_model.g.dart';

@JsonSerializable()
class WeatherItemModel {
  @JsonKey(name: 'main')
  final String? title;
  final String? description;
  final String? icon;

  WeatherItemModel(
    this.title,
    this.description,
    this.icon,
  );

  factory WeatherItemModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherItemModelToJson(this);
}
