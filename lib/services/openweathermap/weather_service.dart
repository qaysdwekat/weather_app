
import '../../core/exceptions/server_exception.dart';
import '../../core/network/abstract_http_network.dart';
import '../../core/network/server_response.dart';
import '../../environments/config/config.dart';
import '../../models/weather_info_request_model.dart';
import '../../models/weather_model.dart';
import '../../features/weather/data/services/abstract_weather_service.dart';

class WeatherService extends AbstractWeatherService {
  static const weatherPath = 'onecall';

  late final AbstractHttpNetwork _network;

  WeatherService(this._network);

  @override
  Future<WeatherModel> getWeatherInfo(WeatherInfoRequestModel info) async {
    try {
      final token = Config().weatherToken;
      final response = await _network.makeGetRequest(weatherPath, queryParameters: {
        ...info.toJson(),
        'appid': token,
      });

      final loginResponse = WeatherModel.fromJson(response.data);
      return loginResponse;
    } on ServerResponse catch (e) {
      throw ServerException(message: e.statusMessage?.toString());
    } catch (e) {
      rethrow;
    }
  }
}
