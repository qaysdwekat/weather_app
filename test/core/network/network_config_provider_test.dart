import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/abstract_network_config_provider.dart';

import 'network_config_provider_test.mocks.dart';

class NetworkConfigProvider extends Mock implements AbstractNetworkConfigProvider {}

@GenerateMocks([NetworkConfigProvider])
void main() {
  AbstractNetworkConfigProvider configProvider = MockNetworkConfigProvider();

  testTimeOutConfig(configProvider);
  testHeadersConfig(configProvider);
}

void testTimeOutConfig(AbstractNetworkConfigProvider configProvider) {
  final List<Map<String, dynamic>> timeOutConfigProviderTestCases = [
    {
      'description': 'Successful Get TimeOut Config',
      'expectedResult': 30,
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Exception Get TimeOut Config',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Wrong type of data')
    },
  ];

  group('TimeOut Config Provider Test', () {
    for (var testCase in timeOutConfigProviderTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the getTimeOut method in the MockNetworkConfigProvider
        if (expectedError) {
          when(configProvider.getTimeOut()).thenThrow(error);
        } else {
          when(configProvider.getTimeOut()).thenAnswer(
            (_) => expectedResult,
          );
        }
        // Call the method and verify the expectations
        try {
          final result = configProvider.getTimeOut();

          verify(configProvider.getTimeOut());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(configProvider.getTimeOut());
          expect(e, error);
        }
      });
    }
  });
}

void testHeadersConfig(AbstractNetworkConfigProvider configProvider) {
  final List<Map<String, dynamic>> headersConfigProviderTestCases = [
    {
      'description': 'Successful Get Headers Config',
      'expectedResult': {
        'Accepted-Language': 'en',
        'build': 4,
      },
      'expectedError': false,
      'error': null,
    },
    {
      'description': ' Get Empty Headers Config',
      'expectedResult': {},
      'expectedError': true,
      'error': Exception("type '_Map<String, Object>' is not a subtype of type 'Future<Map<String, Object?>>'"),
    },
    {
      'description': 'Exception Get Headers Config',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Wrong type of data')
    },
  ];

  group('Headers Config Provider Test', () {
    for (var testCase in headersConfigProviderTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the getHeaders method in the MockNetworkConfigProvider
        if (expectedError) {
          when(configProvider.getHeaders()).thenThrow(error);
        } else {
          when(configProvider.getHeaders()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final Map<String, Object> result = await configProvider.getHeaders();

          verify(configProvider.getHeaders());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(configProvider.getHeaders());
          expect(e, error);
        }
      });
    }
  });
}
