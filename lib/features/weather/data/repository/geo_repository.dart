import 'package:weather_app/features/weather/domain/entities/geo/city_item.dart';

import '../../../../core/base/usecase_value.dart';
import '../../../../core/exceptions/general_exception.dart';
import '../../../../core/exceptions/server_exception.dart';
import '../../domain/repositories/abstract_geo_repository.dart';
import '../services/abstract_geo_service.dart';

class GeoRepository extends AbstractGeoRepository {
  final AbstractGeoService service;
  GeoRepository(this.service);

  @override
  Future<UsecaseValue<List<CityItem>>> fetchCities() async {
    try {
      final weather = await service.fetchCities();
      return UsecaseValue.success(weather);
    } on ServerException catch (e) {
      return UsecaseValue.exception(e);
    } catch (e) {
      return UsecaseValue.exception(GeneralException(message: e.toString()));
    }
  }
}
