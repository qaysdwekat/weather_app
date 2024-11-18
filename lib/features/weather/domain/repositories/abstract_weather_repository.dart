import '../../../../core/base/usecase_value.dart';
import '../entities/weather_info_request.dart';
import '../entities/weather_item.dart';

abstract class AbstractWeatherRepository {
  Future<UsecaseValue<WeatherItem>> getWeatherInfo(WeatherInfoRequest info);
}
