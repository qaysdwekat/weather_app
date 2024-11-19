import 'dart:async';

import '../../../../core/base/single_usecase.dart';
import '../../../../core/base/usecase_value.dart';
import '../entities/geo/city_item.dart';
import '../repositories/abstract_geo_repository.dart';

class FetchCitiesUsecase extends SingleUsecase<List<CityItem>> {
  final AbstractGeoRepository repo;

  FetchCitiesUsecase(this.repo);

  @override
  FutureOr<UsecaseValue<List<CityItem>>> call() {
    return repo.fetchCities();
  }
}
