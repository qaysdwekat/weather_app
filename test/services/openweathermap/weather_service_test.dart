import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/weather/data/services/abstract_weather_service.dart';
import 'package:weather_app/models/weather_info_request_model.dart';
import 'package:weather_app/models/weather_model.dart';

import 'weather_service_test.mocks.dart';

class WeatherService extends Mock implements AbstractWeatherService {}

// Define a mock class for any dependencies
class TestWeatherModel extends Mock implements WeatherModel {}

class TestWeatherInfoRequestModel extends Mock implements WeatherInfoRequestModel {}

@GenerateMocks([WeatherService, TestWeatherModel, TestWeatherInfoRequestModel])
void main() {
  AbstractWeatherService weatherService = MockWeatherService();
  testGetWeatherInfoWithMockWeatherModel(weatherService);
}

void testGetWeatherInfoWithMockWeatherModel(AbstractWeatherService dioHttpNetwork) {
  final List<Map<String, dynamic>> getRequestwithServerResponseTestCases = [
    {
      'description': 'Successful GET Weather Info',
      'request': TestWeatherInfoRequestModel(),
      'expectedResult': TestWeatherModel(),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Fail GET Weather Info',
      'request': WeatherInfoRequestModel(
        latitude: null,
        longitude: null,
      ),
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Latitude, Longitude should be provided')
    },
  ];

  group('Get Weather Info With Mock Weather Model', () {
    for (var testCase in getRequestwithServerResponseTestCases) {
      final description = testCase['description'];
      final request = testCase['request'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the makeGetRequest method in the MockDioHttpNetwork
        if (expectedError) {
          when(dioHttpNetwork.getWeatherInfo(
            request,
          )).thenThrow(error);
        } else {
          when(dioHttpNetwork.getWeatherInfo(
            request,
          )).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await dioHttpNetwork.getWeatherInfo(
            request,
          );

          verify(dioHttpNetwork.getWeatherInfo(
            request,
          ));

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(dioHttpNetwork.getWeatherInfo(
            request,
          ));
          expect(e, error);
        }
      });
    }
  });
}
