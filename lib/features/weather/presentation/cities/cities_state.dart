import 'package:equatable/equatable.dart';

import '../../domain/entities/geo/city_item.dart';

sealed class CitiesState extends Equatable {
  final List<CityItem> cities;

  const CitiesState(
    this.cities,
  );

  @override
  List<Object?> get props => [cities];
}

class InitialState extends CitiesState {
  InitialState()
      : super(
          [
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
          ],
        );
}

class LoadingState extends CitiesState {
  LoadingState()
      : super(
          [
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
            CityItem.empty(),
          ],
        );
}

class LoadedState extends CitiesState {
  const LoadedState(super.cities);
}

class ErrorState extends CitiesState {
  final String? error;

  const ErrorState(this.error) : super(const []);
}
