import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/usecase_value.dart';
import '../../../../models/weather/temperature_unit.dart';
import '../../domain/usecase/get_weather_info_usecase.dart';
import 'events/abstract_weather_event.dart';
import 'events/get_weather_info_event.dart';
import 'events/refresh_weather_info_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<AbstractWeatherEvent, WeatherState> {
  WeatherBloc(GetWeatherInfoUsecase weatherInfoUsecase) : super(InitialState()) {
    on<GetWeatherInfoEvent>((event, emit) async {
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info, state));
    });
    on<RefreshWeatherInfoEvent>((event, emit) async {
      emit(LoadingState(unit: event.weatherInfoRequest.units ?? TemperatureUnit.standard));
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info, state));
    });
  }

  WeatherState _eitherSuccessOrErrorState(
    UsecaseValue? response,
    WeatherState state,
  ) {
    switch (response) {
      case UsecaseSuccess():
        return LoadedState(response.result, unit: state.unit);
      case AppFailureException():
        return ErrorState(response.exception.message);
      default:
        throw 'FailureOrSuccess should be UsecaseSuccess or AppFailureException.';
    }
  }
}
