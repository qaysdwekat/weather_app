import 'server_response.dart';

abstract class AbstractHttpNetwork {
  Future<ServerResponse> makeGetRequest(
    String path, {
    String? token,
    Map<String, dynamic>? queryParameters,
  });
}
