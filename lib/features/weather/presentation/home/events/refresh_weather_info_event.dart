import '../../../domain/entities/weather_info_request.dart';
import 'abstract_home_event.dart';

class RefreshWeatherInfoEvent extends AbstractHomeEvent {
  final WeatherInfoRequest weatherInfoRequest;
  RefreshWeatherInfoEvent(this.weatherInfoRequest);
}
