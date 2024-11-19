import '../../core/exceptions/server_exception.dart';
import '../../core/network/abstract_http_network.dart';
import '../../core/network/server_response.dart';
import '../../features/weather/data/services/abstract_geo_service.dart';
import '../../models/geo/city_model.dart';

class GeoService extends AbstractGeoService {
  static const weatherPath = 'onecall';

  late final AbstractHttpNetwork _network;

  GeoService(this._network);

  @override
  Future<List<CityModel>> fetchCities() async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final response = ServerResponse(data: [
        {'name': 'Berlin', 'latitude': '52.5200', 'longitude': '13.4050'},
        {'name': 'Karlsruhe', 'latitude': '49.0069', 'longitude': '8.4037'},
        {'name': 'Frankfurt', 'latitude': '50.1109', 'longitude': '8.6821'},
        {'name': 'London', 'latitude': '51.5074', 'longitude': '-0.1278'},
        {'name': 'Madrid', 'latitude': '40.4168', 'longitude': '-3.7038'},
      ], statusCode: 200);

      final cities = response.data
              ?.map<CityModel>(
                (json) => CityModel.fromJson(json),
              )
              .toList() ??
          [];
      return cities;
    } on ServerResponse catch (e) {
      throw ServerException(message: e.statusMessage?.toString());
    } catch (e) {
      rethrow;
    }
  }
}
