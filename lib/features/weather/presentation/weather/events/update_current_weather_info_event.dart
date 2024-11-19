import '../../../domain/entities/weather/day_weather_item.dart';
import 'abstract_weather_event.dart';

class UpdateCurrentWeatherInfoEvent extends AbstractWeatherEvent {
  final DayWeatherItem weather;
  UpdateCurrentWeatherInfoEvent(this.weather);
}
