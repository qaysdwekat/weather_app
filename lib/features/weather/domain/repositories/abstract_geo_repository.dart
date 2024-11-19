import '../../../../core/base/usecase_value.dart';
import '../entities/geo/city_item.dart';

abstract class AbstractGeoRepository {
  Future<UsecaseValue<List<CityItem>>> fetchCities();
}
