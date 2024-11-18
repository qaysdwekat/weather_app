import 'dart:async';

import '../../../../core/base/single_usecase_with_parameter.dart';
import '../../../../core/base/usecase_value.dart';
import '../entities/weather_info_request.dart';
import '../entities/weather_item.dart';
import '../repositories/abstract_weather_repository.dart';

class GetWeatherInfoUsecase extends SingleUsecaseWithParameter<WeatherItem, WeatherInfoRequest> {
  final AbstractWeatherRepository repo;

  GetWeatherInfoUsecase(this.repo);

  @override
  FutureOr<UsecaseValue<WeatherItem>> call(WeatherInfoRequest data) {
    return repo.getWeatherInfo(data);
  }
}
