import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/base/usecase_value.dart';
import 'package:weather_app/features/weather/domain/entities/weather/day_weather_item.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_data.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_info_request.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_item.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather_info_usecase.dart';
import 'package:weather_app/features/weather/presentation/weather/events/get_weather_info_event.dart';
import 'package:weather_app/features/weather/presentation/weather/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/weather/weather_state.dart';
import 'package:weather_app/models/weather/temperature_unit.dart';

class MockGetWeatherInfoUsecase extends Mock implements GetWeatherInfoUsecase {}

void main() {
  late MockGetWeatherInfoUsecase weatherInfoUsecase;

  late WeatherBloc bloc;

  setUp(() {
    weatherInfoUsecase = MockGetWeatherInfoUsecase();

    bloc = WeatherBloc(
      weatherInfoUsecase,
    );
  });

  group('Get Weather Info Usecase', () {
    const request = WeatherInfoRequest(
      latitude: "52.5200",
      longitude: "13.4050",
    );

    final weatherResponse = WeatherItem(
      current: DayWeatherItem(
        dateTime: DateTime.fromMillisecondsSinceEpoch(1731588909 * 1000),
        temperature: 279.42,
        pressure: 1028,
        humidity: 92,
        windSpeed: 2.69,
        weather: [
          WeatherData(
            title: 'Clouds',
            description: 'overcast clouds',
            icon: '04d',
          ),
        ],
      ),
      daily: [
        DayWeatherItem(
          dateTime: DateTime.fromMillisecondsSinceEpoch(1731588909 * 1000),
          temperature: 279.42,
          pressure: 1028,
          humidity: 92,
          windSpeed: 2.69,
          weather: [
            WeatherData(
              title: 'Clouds',
              description: 'overcast clouds',
              icon: '04d',
            ),
          ],
        )
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
        'Should emit LoadingState and get data in WeatherData when GetWeatherInfoEvent is added and usecase fetchs data successfully',
        build: () {
          when(() => weatherInfoUsecase(request)).thenAnswer((_) async => UsecaseValue.success(weatherResponse));
          return bloc;
        },
        act: (bloc) async {
          bloc.add(GetWeatherInfoEvent(request));
          await untilCalled(() => weatherInfoUsecase(request));
        },
        expect: () => [
              LoadingState(),
              LoadedState(
                weatherResponse,
                unit: request.units ?? TemperatureUnit.metric,
                current: weatherResponse.current,
              ),
            ]);
  });
}
