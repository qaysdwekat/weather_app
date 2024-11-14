import '../entities/weather_info_request.dart';
import '../entities/weather_item.dart';

abstract class AbstractWeatherRepository { 
  Future<WeatherItem> getWeatherInfo(WeatherInfoRequest info);
}