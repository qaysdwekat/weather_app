import 'package:equatable/equatable.dart';

class WeatherItem extends Equatable {
  final DayWeatherItem? current;
  final List<DayWeatherItem>? daily;

  @override
  List<Object?> get props => [];
}
