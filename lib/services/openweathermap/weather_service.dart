import '../../core/exceptions/server_exception.dart';
import '../../core/network/abstract_http_network.dart';
import '../../core/network/server_response.dart';
import '../../environments/config/config.dart';
import '../../features/weather/data/services/abstract_weather_service.dart';
import '../../models/weather_info_request_model.dart';
import '../../models/weather_model.dart';

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
        // 'appid': 'token',
      });

      final weatherInfo = WeatherModel.fromJson(response.data);
      // final weatherInfo = WeatherModel.fromJson({
      //   "lat": 49.0131,
      //   "lon": 8.4043,
      //   "timezone": "Europe/Berlin",
      //   "timezone_offset": 3600,
      //   "current": {
      //     "dt": 1731588909,
      //     "sunrise": 1731566093,
      //     "sunset": 1731599224,
      //     "temp": 279.42,
      //     "feels_like": 277.41,
      //     "pressure": 1028,
      //     "humidity": 92,
      //     "dew_point": 278.22,
      //     "uvi": 0.2,
      //     "clouds": 100,
      //     "visibility": 10000,
      //     "wind_speed": 2.69,
      //     "wind_deg": 228,
      //     "wind_gust": 5.85,
      //     "weather": [
      //       {
      //         "id": 804,
      //         "main": "Clouds",
      //         "description": "overcast clouds",
      //         "icon": "04d",
      //       }
      //     ]
      //   },
      //   "daily": [
      //     {
      //       "dt": 1731582000,
      //       "sunrise": 1731566093,
      //       "sunset": 1731599224,
      //       "moonrise": 1731595380,
      //       "moonset": 1731558840,
      //       "moon_phase": 0.44,
      //       "summary": "Expect a day of partly cloudy with rain",
      //       "temp": {"day": 278.9, "min": 277.58, "max": 279.42, "night": 278.9, "eve": 278.72, "morn": 278.41},
      //       "feels_like": {"day": 276.77, "night": 278.9, "eve": 277.23, "morn": 278.41},
      //       "pressure": 1028,
      //       "humidity": 90,
      //       "dew_point": 277.39,
      //       "wind_speed": 2.92,
      //       "wind_deg": 231,
      //       "wind_gust": 6.46,
      //       "weather": [
      //         {
      //           "id": 500,
      //           "main": "Rain",
      //           "description": "light rain",
      //           "icon": "10d",
      //         }
      //       ],
      //       "clouds": 100,
      //       "pop": 1,
      //       "rain": 0.87,
      //       "uvi": 0.43
      //     },
      //     {
      //       "dt": 1731668400,
      //       "sunrise": 1731652587,
      //       "sunset": 1731685551,
      //       "moonrise": 1731683220,
      //       "moonset": 1731650700,
      //       "moon_phase": 0.5,
      //       "summary": "You can expect partly cloudy in the morning, with clearing in the afternoon",
      //       "temp": {"day": 283.6, "min": 277.31, "max": 284.12, "night": 277.31, "eve": 279.3, "morn": 279.17},
      //       "feels_like": {"day": 282.27, "night": 277.31, "eve": 278.25, "morn": 279.17},
      //       "pressure": 1027,
      //       "humidity": 60,
      //       "dew_point": 276.14,
      //       "wind_speed": 2.48,
      //       "wind_deg": 82,
      //       "wind_gust": 3.99,
      //       "weather": [
      //         {"id": 802, "main": "Clouds", "description": "scattered clouds", "icon": "03d"}
      //       ],
      //       "clouds": 31,
      //       "pop": 0,
      //       "uvi": 0.81
      //     },
      //     {
      //       "dt": 1731754800,
      //       "sunrise": 1731739081,
      //       "sunset": 1731771880,
      //       "moonrise": 1731771540,
      //       "moonset": 1731742500,
      //       "moon_phase": 0.52,
      //       "summary": "You can expect clear sky in the morning, with partly cloudy in the afternoon",
      //       "temp": {"day": 281.2, "min": 275.2, "max": 282.29, "night": 277.5, "eve": 278.26, "morn": 275.6},
      //       "feels_like": {"day": 279.2, "night": 274.81, "eve": 276.31, "morn": 274.23},
      //       "pressure": 1022,
      //       "humidity": 66,
      //       "dew_point": 275.05,
      //       "wind_speed": 3.25,
      //       "wind_deg": 241,
      //       "wind_gust": 9.07,
      //       "weather": [
      //         {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
      //       ],
      //       "clouds": 4,
      //       "pop": 0,
      //       "uvi": 1.15
      //     },
      //     {
      //       "dt": 1731841200,
      //       "sunrise": 1731825574,
      //       "sunset": 1731858211,
      //       "moonrise": 1731860640,
      //       "moonset": 1731834060,
      //       "moon_phase": 0.56,
      //       "summary": "You can expect partly cloudy in the morning, with rain in the afternoon",
      //       "temp": {"day": 280.72, "min": 276.25, "max": 281.83, "night": 280.06, "eve": 279.95, "morn": 276.46},
      //       "feels_like": {"day": 277.56, "night": 276.67, "eve": 276.32, "morn": 273.33},
      //       "pressure": 1013,
      //       "humidity": 72,
      //       "dew_point": 275.92,
      //       "wind_speed": 6.15,
      //       "wind_deg": 252,
      //       "wind_gust": 13.28,
      //       "weather": [
      //         {"id": 500, "main": "Rain", "description": "light rain", "icon": "10d"}
      //       ],
      //       "clouds": 100,
      //       "pop": 1,
      //       "rain": 3.07,
      //       "uvi": 0.85
      //     },
      //     {
      //       "dt": 1731927600,
      //       "sunrise": 1731912067,
      //       "sunset": 1731944545,
      //       "moonrise": 1731950580,
      //       "moonset": 1731924720,
      //       "moon_phase": 0.6,
      //       "summary": "Expect a day of partly cloudy with rain",
      //       "temp": {"day": 281.03, "min": 279.22, "max": 281.13, "night": 281.13, "eve": 279.73, "morn": 279.22},
      //       "feels_like": {"day": 277.93, "night": 278.16, "eve": 278.43, "morn": 275.8},
      //       "pressure": 1016,
      //       "humidity": 68,
      //       "dew_point": 275.38,
      //       "wind_speed": 5.67,
      //       "wind_deg": 249,
      //       "wind_gust": 12.34,
      //       "weather": [
      //         {"id": 500, "main": "Rain", "description": "light rain", "icon": "10d"}
      //       ],
      //       "clouds": 100,
      //       "pop": 0.62,
      //       "rain": 1.33,
      //       "uvi": 0.06
      //     },
      //     {
      //       "dt": 1732014000,
      //       "sunrise": 1731998559,
      //       "sunset": 1732030881,
      //       "moonrise": 1732041240,
      //       "moonset": 1732014300,
      //       "moon_phase": 0.63,
      //       "summary": "You can expect partly cloudy with rain in the morning, with snow in the afternoon",
      //       "temp": {"day": 282.59, "min": 276.41, "max": 282.59, "night": 276.41, "eve": 276.52, "morn": 281.79},
      //       "feels_like": {"day": 278.4, "night": 272.27, "eve": 271.79, "morn": 277.65},
      //       "pressure": 988,
      //       "humidity": 81,
      //       "dew_point": 279.33,
      //       "wind_speed": 12,
      //       "wind_deg": 239,
      //       "wind_gust": 23.57,
      //       "weather": [
      //         {"id": 616, "main": "Snow", "description": "rain and snow", "icon": "13d"}
      //       ],
      //       "clouds": 100,
      //       "pop": 1,
      //       "rain": 13.63,
      //       "snow": 0.78,
      //       "uvi": 1
      //     },
      //     {
      //       "dt": 1732100400,
      //       "sunrise": 1732085050,
      //       "sunset": 1732117220,
      //       "moonrise": 1732132260,
      //       "moonset": 1732102980,
      //       "moon_phase": 0.67,
      //       "summary": "There will be partly cloudy with rain until morning, then partly cloudy with snow",
      //       "temp": {"day": 275.51, "min": 273.63, "max": 276.01, "night": 273.63, "eve": 273.77, "morn": 275.13},
      //       "feels_like": {"day": 270.34, "night": 268.22, "eve": 268.11, "morn": 270.51},
      //       "pressure": 1009,
      //       "humidity": 71,
      //       "dew_point": 270.63,
      //       "wind_speed": 6.83,
      //       "wind_deg": 253,
      //       "wind_gust": 12.15,
      //       "weather": [
      //         {"id": 616, "main": "Snow", "description": "rain and snow", "icon": "13d"}
      //       ],
      //       "clouds": 99,
      //       "pop": 1,
      //       "rain": 0.18,
      //       "snow": 2.1,
      //       "uvi": 1
      //     },
      //     {
      //       "dt": 1732186800,
      //       "sunrise": 1732171540,
      //       "sunset": 1732203561,
      //       "moonrise": 1732223220,
      //       "moonset": 1732191000,
      //       "moon_phase": 0.7,
      //       "summary": "You can expect partly cloudy with snow in the morning, with rain in the afternoon",
      //       "temp": {"day": 274.47, "min": 271.61, "max": 275.56, "night": 274.34, "eve": 274.92, "morn": 271.66},
      //       "feels_like": {"day": 267.88, "night": 269.39, "eve": 270.17, "morn": 265.35},
      //       "pressure": 1006,
      //       "humidity": 94,
      //       "dew_point": 273.44,
      //       "wind_speed": 9.96,
      //       "wind_deg": 246,
      //       "wind_gust": 18.85,
      //       "weather": [
      //         {"id": 616, "main": "Snow", "description": "rain and snow", "icon": "13d"}
      //       ],
      //       "clouds": 86,
      //       "pop": 1,
      //       "rain": 0.24,
      //       "snow": 3.15,
      //       "uvi": 1
      //     }
      //   ]
      // });
      return weatherInfo;
    } on ServerResponse catch (e) {
      throw ServerException(message: e.statusMessage?.toString());
    } catch (e) {
      rethrow;
    }
  }
}
