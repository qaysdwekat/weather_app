import '../../../domain/entities/weather/weather_info_request.dart';
import 'abstract_weather_event.dart';

class GetWeatherInfoEvent extends AbstractWeatherEvent {
  final WeatherInfoRequest weatherInfoRequest;
  GetWeatherInfoEvent(this.weatherInfoRequest);
}
