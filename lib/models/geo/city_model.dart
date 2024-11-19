import 'package:json_annotation/json_annotation.dart';

import '../../features/weather/domain/entities/geo/city_item.dart';

part 'city_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CityModel extends CityItem {
  const CityModel({
    required super.latitude,
    required super.longitude,
    required super.name,
  });

  factory CityModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
