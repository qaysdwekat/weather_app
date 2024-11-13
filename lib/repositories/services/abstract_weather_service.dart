import '../../models/weather_info_request.dart';
import '../../models/weather_model.dart';

abstract class AbstractWeatherService {
  Future<WeatherModel> getWeatherInfo(WeatherInfoRequest info);
}
