import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/abstract_http_network.dart';
import '../../../core/network/abstract_network_config_provider.dart';
import '../../../core/network/server_response.dart';
import 'dio_extensions.dart';

typedef ResponseValue = Future<dynamic> Function(Options? diOptions);

class DioHttpNetwork implements AbstractHttpNetwork {
  late Dio _dio;

  DioHttpNetwork({
    String? baseUrl,
    required AbstractNetworkConfigProvider configProvider,
    String contentType = Headers.jsonContentType,
  }) {
    final duration = Duration(
      seconds: configProvider.getTimeOut(),
    );

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: duration,
      receiveTimeout: duration,
      sendTimeout: duration,
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          final headers = await configProvider.getHeaders();
          headers[HttpHeaders.contentTypeHeader] = contentType;
          options.headers.addAll(headers);
          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<ServerResponse> makeGetRequest(
    String path, {
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        _dio.options.headers.addAll({
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      }
      Options? diOptions;

      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: diOptions,
      );

      if (!response.ok) {
        throw const ServerResponse();
      }

      return ServerResponse(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          type: ServerResponseType.success);
    } on DioException catch (e) {
      ServerResponse error;
      switch (e.type) {
        case DioExceptionType.connectionError:
          error = const ServerResponse(
            type: ServerResponseType.connectionError,
          );
        case DioExceptionType.connectionTimeout:
          error = const ServerResponse(
            type: ServerResponseType.timeout,
          );
        case DioExceptionType.sendTimeout:
          error = const ServerResponse(
            type: ServerResponseType.timeout,
          );
        case DioExceptionType.receiveTimeout:
          error = const ServerResponse(
            type: ServerResponseType.timeout,
          );
        default:
          error = const ServerResponse(
            type: ServerResponseType.error,
          );
      }

      String message = e.message ?? '';
      try {
        //For Our APIs the cause is the reason of the error & the message is the title so we show the reason first
        message = e.response?.data['cause'] ?? e.response?.data['message'] ?? e.message;
      } catch (_) {}

      error = error.copyWith(
        data: e.response?.data,
        statusCode: e.response?.statusCode,
        statusMessage: message,
      );

      throw error;
    } catch (e) {
      throw ServerResponse(
        type: ServerResponseType.error,
        statusCode: -1,
        statusMessage: e.toString(),
      );
    }
  }
}
