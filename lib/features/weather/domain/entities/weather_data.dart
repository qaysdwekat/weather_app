import 'package:equatable/equatable.dart';
import 'package:weather_app/environments/config/config.dart';

class WeatherData extends Equatable {
  final String? title;
  final String? description;
  final String? icon;

  const WeatherData({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        icon,
      ];

  String? get iconUrl => icon != null
      ? Config().openweathermapImageUrl?.replaceAll(
            '{icon}',
            icon!,
          )
      : null;
}
