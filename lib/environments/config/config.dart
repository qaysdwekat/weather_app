import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: false, fieldRename: FieldRename.snake)
class Config {
  String? env;

  bool? production;

  String? baseUrl;

  String? weatherToken;

  String? openweathermapImageUrl;

  static Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  static void setConfig(config) {
    _instance = _$ConfigFromJson(config);
  }
}
