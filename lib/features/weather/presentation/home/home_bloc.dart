import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/repositories/abstract_weather_repository.dart';

import 'events/abstract_home_event.dart';
import 'events/get_weather_info_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<AbstractHomeEvent, HomeState> {
  HomeBloc(AbstractWeatherRepository repository) : super(HomeState.init()) {
    on<GetWeatherInfoEvent>((event, emit) async {
      final info = await repository.getWeatherInfo(event.weatherInfoRequest);
      if (kDebugMode) {
        print(info);
      }
    });
  }
}
