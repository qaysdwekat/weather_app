import '../../../../models/weather/weather_info_request_model.dart';
import '../../../../models/weather/weather_model.dart';

abstract class AbstractWeatherService {
  Future<WeatherModel> getWeatherInfo(WeatherInfoRequestModel info);
}
