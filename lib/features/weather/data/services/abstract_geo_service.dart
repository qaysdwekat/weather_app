
import '../../../../models/geo/city_model.dart';

abstract class AbstractGeoService {
  Future<List<CityModel>> fetchCities();
}
