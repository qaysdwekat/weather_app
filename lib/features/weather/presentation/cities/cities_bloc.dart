import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/usecase_value.dart';

import '../../domain/usecase/fetch_cities_usecase.dart';
import 'cities_state.dart';
import 'events/abstract_cities_event.dart';
import 'events/fetch_cities_event.dart';

class CitiesBloc extends Bloc<AbstractCitiesEvent, CitiesState> {
  CitiesBloc(FetchCitiesUsecase fetchCitiesUsecase) : super(InitialState()) {
    on<FetchCitiesEvent>((event, emit) async {
      final info = await fetchCitiesUsecase();
      emit(_eitherSuccessOrErrorState(info, state));
    });
  }

  CitiesState _eitherSuccessOrErrorState(
    UsecaseValue? response,
    CitiesState state,
  ) {
    switch (response) {
      case UsecaseSuccess():
        return LoadedState(response.result,);
      case AppFailureException():
        return ErrorState(response.exception.message);
      default:
        throw 'FailureOrSuccess should be UsecaseSuccess or AppFailureException.';
    }
  }
}
