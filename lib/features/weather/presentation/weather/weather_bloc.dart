import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/usecase_value.dart';
import '../../../../models/weather/temperature_unit.dart';
import '../../domain/entities/weather/weather_item.dart';
import '../../domain/usecase/get_weather_info_usecase.dart';
import 'events/abstract_weather_event.dart';
import 'events/get_weather_info_event.dart';
import 'events/refresh_weather_info_event.dart';
import 'events/update_current_weather_info_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<AbstractWeatherEvent, WeatherState> {
  WeatherBloc(GetWeatherInfoUsecase weatherInfoUsecase) : super(InitialState()) {
    on<GetWeatherInfoEvent>((event, emit) async {
      emit(LoadingState());
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info, state));
    });
    on<RefreshWeatherInfoEvent>((event, emit) async {
      emit(LoadingState(unit: event.weatherInfoRequest.units ?? TemperatureUnit.standard));
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info, state));
    });

    on<UpdateCurrentWeatherInfoEvent>((event, emit) async {
      final info = state.weatherInfo;
      final unit = state.unit;
      final current = event.weather;
      emit(LoadedCurrentWeatherState(
        info,
        unit: unit,
        current: current,
      ));
    });
  }

  WeatherState _eitherSuccessOrErrorState(
    UsecaseValue? response,
    WeatherState state,
  ) {
    switch (response) {
      case UsecaseSuccess():
        final WeatherItem weather = response.result;
        return LoadedState(
          weather,
          unit: state.unit,
          current: weather.current,
        );
      case AppFailureException():
        return ErrorState(response.exception.message);
      default:
        throw 'FailureOrSuccess should be UsecaseSuccess or AppFailureException.';
    }
  }
}
