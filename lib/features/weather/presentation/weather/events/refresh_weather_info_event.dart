import '../../../domain/entities/weather/weather_info_request.dart';
import 'abstract_weather_event.dart';

class RefreshWeatherInfoEvent extends AbstractWeatherEvent {
  final WeatherInfoRequest weatherInfoRequest;
  RefreshWeatherInfoEvent(this.weatherInfoRequest);
}
