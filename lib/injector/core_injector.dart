import 'package:get_it/get_it.dart';
import 'package:weather_app/environments/config/config.dart';

import '../core/network/abstract_http_network.dart';
import '../core/network/abstract_network_config_provider.dart';
import '../features/weather/data/repository/geo_repository.dart';
import '../features/weather/data/repository/weather_repository.dart';
import '../features/weather/data/services/abstract_geo_service.dart';
import '../features/weather/data/services/abstract_weather_service.dart';
import '../features/weather/domain/repositories/abstract_geo_repository.dart';
import '../features/weather/domain/repositories/abstract_weather_repository.dart';
import '../features/weather/domain/usecase/fetch_cities_usecase.dart';
import '../features/weather/domain/usecase/get_weather_info_usecase.dart';
import '../features/weather/presentation/cities/cities_bloc.dart';
import '../features/weather/presentation/weather/weather_bloc.dart';
import '../services/dio/dio_http_network.dart';
import '../services/dio/dio_network_config_provider.dart';
import '../services/geo/geo_service.dart';
import '../services/openweathermap/weather_service.dart';

final dInstance = GetIt.instance;

Future<void> init() async {
  dInstance.registerSingleton<AbstractNetworkConfigProvider>(DioNetworkConfigProvider());

  final clinet = DioHttpNetwork(
    baseUrl: Config().baseUrl,
    configProvider: dInstance.call(),
  );

  dInstance.registerSingleton<AbstractHttpNetwork>(clinet);

  dInstance.registerSingleton<AbstractWeatherService>(WeatherService(dInstance.call()));

  dInstance.registerSingleton<AbstractGeoService>(GeoService(dInstance.call()));

  dInstance.registerSingleton<AbstractWeatherRepository>(WeatherRepository(dInstance.call()));

  dInstance.registerSingleton<AbstractGeoRepository>(GeoRepository(dInstance.call()));

  dInstance.registerFactory(
    () => GetWeatherInfoUsecase(
      dInstance.call(),
    ),
  );

  dInstance.registerFactory(
    () => FetchCitiesUsecase(
      dInstance.call(),
    ),
  );

  dInstance.registerFactory(() => CitiesBloc(
        dInstance.call(),
      ));

  dInstance.registerFactory(() => WeatherBloc(
        dInstance.call(),
      ));
}
