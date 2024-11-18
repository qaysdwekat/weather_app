import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/usecase_value.dart';
import '../../domain/usecase/get_weather_info_usecase.dart';
import 'events/abstract_home_event.dart';
import 'events/get_weather_info_event.dart';
import 'events/refresh_weather_info_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<AbstractHomeEvent, HomeState> {
  HomeBloc(GetWeatherInfoUsecase weatherInfoUsecase) : super(InitialState()) {
    on<GetWeatherInfoEvent>((event, emit) async {
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info));
    });
    on<RefreshWeatherInfoEvent>((event, emit) async {
      emit(LoadingState());
      final info = await weatherInfoUsecase(event.weatherInfoRequest);
      emit(_eitherSuccessOrErrorState(info));
    });
  }

  HomeState _eitherSuccessOrErrorState(
    UsecaseValue? response,
  ) {
    switch (response) {
      case UsecaseSuccess():
        return LoadedState(response.result);
      case AppFailureException():
        return ErrorState(response.exception.message);
      default:
        throw 'FailureOrSuccess should be UsecaseSuccess or AppFailureException.';
    }
  }
}
