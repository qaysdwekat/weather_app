import 'package:get_it/get_it.dart';
import 'package:weather_app/environments/config/config.dart';

import '../core/network/abstract_http_network.dart';
import '../core/network/abstract_network_config_provider.dart';
import '../features/weather/data/repository/weather_repository.dart';
import '../features/weather/data/services/abstract_weather_service.dart';
import '../features/weather/domain/repositories/abstract_weather_repository.dart';
import '../features/weather/domain/usecase/get_weather_info_usecase.dart';
import '../features/weather/presentation/home/home_bloc.dart';
import '../services/dio/dio_http_network.dart';
import '../services/dio/dio_network_config_provider.dart';
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

  dInstance.registerSingleton<AbstractWeatherRepository>(WeatherRepository(dInstance.call()));

  dInstance.registerFactory(
    () => GetWeatherInfoUsecase(
      dInstance.call(),
    ),
  );

  dInstance.registerFactory(() => HomeBloc(
        dInstance.call(),
      ));
}
