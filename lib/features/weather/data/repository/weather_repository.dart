
import '../../domain/repositories/abstract_weather_repository.dart';
import '../../domain/entities/weather_info_request.dart';
import '../../domain/entities/weather_item.dart';
import '../../../../models/weather_info_request_model.dart';
import '../services/abstract_weather_service.dart';

class WeatherRepository extends AbstractWeatherRepository {
  final AbstractWeatherService service;
  WeatherRepository(this.service);

  @override
  Future<WeatherItem> getWeatherInfo(WeatherInfoRequest info) async {
    try {
      final weather = await service.getWeatherInfo(
        WeatherInfoRequestModel.fromRequest(
          info,
        ),
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
