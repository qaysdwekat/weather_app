import '../../../../core/base/usecase_value.dart';
import '../../../../core/exceptions/general_exception.dart';
import '../../../../core/exceptions/server_exception.dart';
import '../../../../models/weather_info_request_model.dart';
import '../../domain/entities/weather_info_request.dart';
import '../../domain/entities/weather_item.dart';
import '../../domain/repositories/abstract_weather_repository.dart';
import '../services/abstract_weather_service.dart';

class WeatherRepository extends AbstractWeatherRepository {
  final AbstractWeatherService service;
  WeatherRepository(this.service);

  @override
  Future<UsecaseValue<WeatherItem> >getWeatherInfo(WeatherInfoRequest info) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      final weather = await service.getWeatherInfo(
        WeatherInfoRequestModel.fromRequest(
          info,
        ),
      );
      return UsecaseValue.success(weather);
    } on ServerException catch (e) {
      return UsecaseValue.exception(e);
    } catch (e) {
      return UsecaseValue.exception(GeneralException(message: e.toString()));
    }
  }
}
