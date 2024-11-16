import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/abstract_http_network.dart';
import 'package:weather_app/core/network/server_response.dart';

import 'dio_http_network_test.mocks.dart';

class DioHttpNetwork extends Mock implements AbstractHttpNetwork {}

// Define a mock class for any dependencies
class TestServerResponse extends Mock implements ServerResponse {}

@GenerateMocks([DioHttpNetwork, TestServerResponse])
void main() {
  AbstractHttpNetwork dioHttpNetwork = MockDioHttpNetwork();

  testGetRequestWithMockServerResponse(dioHttpNetwork);
  testGetRequestWithServerResponseAndStatusCode(dioHttpNetwork);
}

void testGetRequestWithMockServerResponse(AbstractHttpNetwork dioHttpNetwork) {
  final List<Map<String, dynamic>> getRequestwithServerResponseTestCases = [
    {
      'description': 'Successful GET Server Response',
      'path': '/example',
      'token': 'mock_token',
      'queryParameters': {'param1': 'value1'},
      'expectedResult': MockTestServerResponse(),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Fail GET Server Response',
      'path': '/example',
      'token': 'mock_token',
      'queryParameters': {'param1': 'value1'},
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Test error')
    },
  ];

  group('Get Request With Mock Server Response Test', () {
    for (var testCase in getRequestwithServerResponseTestCases) {
      final description = testCase['description'];
      final path = testCase['path'];
      final token = testCase['token'];
      final expectedResult = testCase['expectedResult'];
      final queryParameters = testCase['queryParameters'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the makeGetRequest method in the MockDioHttpNetwork
        if (expectedError) {
          when(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          )).thenThrow(error);
        } else {
          when(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          )).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          );

          verify(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
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
          verify(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          ));
          expect(e, error);
        }
      });
    }
  });
}

void testGetRequestWithServerResponseAndStatusCode(AbstractHttpNetwork dioHttpNetwork) {
  final List<Map<String, dynamic>> getRequestwithServerResponseTestCases = [
    {
      'description': 'Successful GET Server Response with statusCode: 200',
      'path': '/example',
      'token': 'mock_token',
      'queryParameters': {'param1': 'value1'},
      'expectedResult': const ServerResponse(statusCode: 200),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Fail GET Server Response with statusCode: 400',
      'path': '/example',
      'token': 'mock_token',
      'queryParameters': {'param1': 'value1'},
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Test error')
    },
  ];

  group('Get Request With Mock Server Response Test', () {
    for (var testCase in getRequestwithServerResponseTestCases) {
      final description = testCase['description'];
      final path = testCase['path'];
      final token = testCase['token'];
      final expectedResult = testCase['expectedResult'];
      final queryParameters = testCase['queryParameters'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the makeGetRequest method in the MockDioHttpNetwork
        if (expectedError) {
          when(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          )).thenThrow(error);
        } else {
          when(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          )).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final result = await dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          );

          verify(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
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
          verify(dioHttpNetwork.makeGetRequest(
            path,
            token: token,
            queryParameters: queryParameters,
          ));
          expect(e, error);
        }
      });
    }
  });
}
