import 'package:weather_app/environments/config/config.dart';

import '../../core/exceptions/server_exception.dart';
import '../../core/network/abstract_http_network.dart';
import '../../core/network/server_response.dart';
import '../../models/weather_info_request.dart';
import '../../models/weather_model.dart';
import '../../repositories/services/abstract_weather_service.dart';

class WeatherService extends AbstractWeatherService {
  static const weatherPath = 'onecall';

  late final AbstractHttpNetwork _network;

  WeatherService(this._network);

  @override
  Future<WeatherModel> getWeatherInfo(WeatherInfoRequest info) async {
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
