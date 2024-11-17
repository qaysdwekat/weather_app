import '../../../domain/entities/weather_info_request.dart';
import 'abstract_home_event.dart';

class GetWeatherInfoEvent extends AbstractHomeEvent {
  final WeatherInfoRequest weatherInfoRequest;
  GetWeatherInfoEvent(this.weatherInfoRequest);
}
