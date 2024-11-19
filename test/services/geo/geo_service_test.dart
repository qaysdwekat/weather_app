import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/weather/data/services/abstract_geo_service.dart';
import 'package:weather_app/models/geo/city_model.dart';

import 'geo_service_test.mocks.dart';

class GeoService extends Mock implements AbstractGeoService {}

// Define a mock class for any dependencies
class TestCityModel extends Mock implements CityModel {}

@GenerateMocks([GeoService, TestCityModel])
void main() {
  AbstractGeoService weatherService = MockGeoService();
  testFetchCitiesWithServerResponse(weatherService);
}

void testFetchCitiesWithServerResponse(AbstractGeoService geoService) {
  final List<Map<String, dynamic>> fetchCitiesTestCases = [
    {
      'description': 'Successful GET List Of Cities',
      'expectedResult': [TestCityModel(), TestCityModel()],
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Fail GET List Of Cities',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Unable to get Cities')
    },
  ];

  group('Fetch List Of Cities Mock City Model', () {
    for (var testCase in fetchCitiesTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the makeGetRequest method in the MockDioHttpNetwork
        if (expectedError) {
          when(geoService.fetchCities()).thenThrow(error);
        } else {
          when(geoService.fetchCities()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await geoService.fetchCities();

          verify(geoService.fetchCities());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(geoService.fetchCities());
          expect(e, error);
        }
      });
    }
  });
}
