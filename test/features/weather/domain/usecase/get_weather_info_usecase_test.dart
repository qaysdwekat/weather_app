import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/base/usecase_value.dart';
import 'package:weather_app/features/weather/domain/entities/weather/day_weather_item.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_data.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_info_request.dart';
import 'package:weather_app/features/weather/domain/entities/weather/weather_item.dart';
import 'package:weather_app/features/weather/domain/repositories/abstract_weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather_info_usecase.dart';

class MockWeatherRepository extends Mock implements AbstractWeatherRepository {}

void main() {
  late MockWeatherRepository repository;
  late GetWeatherInfoUsecase usecase;

  setUp(() {
    repository = MockWeatherRepository();
    usecase = GetWeatherInfoUsecase(repository);
  });

  const info = WeatherInfoRequest(
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
  test("Should Get Weather Info From The Repository", () async {
    //arrange
    when(() => repository.getWeatherInfo(info)).thenAnswer(
      (_) async => UsecaseValue.success(weatherResponse),
    );
    //act
    final result = await usecase(info);
    //assert
    expect(result, UsecaseSuccess<WeatherItem>(weatherResponse));
    verify(() => repository.getWeatherInfo(info));
    verifyNoMoreInteractions(repository);
  });
}
